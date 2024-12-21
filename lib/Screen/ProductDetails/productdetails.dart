import 'dart:convert';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_bloc.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_event.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/SeeMoreText.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class ProductdetailsScreen extends StatefulWidget {
  const ProductdetailsScreen({super.key});

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  var items = <Product>[];

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<ProductdetailsBloc>(context).add(SetProductdetails());
    setState(() {
      loadPrefs();
    });
    loadUsers();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  Future<List<ProductsResponse>> loadUsers() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      List<dynamic> usersJson = jsonMap['products'];
      // List<ProductsResponse> users =
      //     usersJson.map((json) => ProductsResponse.fromJson(json)).toList();
      items = ProductsResponse.fromJson(jsonMap).products!;
      print("//////");
      print(items[0].name);
      return [];
    } catch (e) {
      print('Error loading JSON: $e');
      return []; // Return an empty list or handle as needed
    }
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: mPrimaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  void OnLoadNext() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProductdetailsBloc, ProductdetailsState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is ProductdetailsLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetProductdetailsInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Image with Title
                    Stack(
                      children: [
                        Image.asset(
                          'assets/dummyy.jpg', // Replace with your image asset
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(
                              size: 30,
                              color: Colors.white,
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              // Navigator.pop(context); // Navigate back
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                          latLng: LatLng(0.0, 0.0),
                                          screenpostion: 0,
                                        )),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Chip(
                            side: BorderSide.none,
                            labelPadding: EdgeInsets.zero,
                            backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30.0), // Custom radius
                            ),
                            label: SvgPicture.asset(
                              'assets/ic_unfavorite.svg',
                              width: 24,
                              height: 24,
                              //color: isSelected ? selectedColor : color,
                            ),
                          ),
                        ),

                        // Right Corner Positioned Image

                        Positioned(
                          bottom: 40,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              '5+ left',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Main Content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: CircleAvatar(
                                  radius: 20,
                                  child: ClipOval(
                                    child: Image.network(
                                      "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Restrant Name",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansSemiBold',
                                          fontSize: 13.sp,
                                          color: mGrey),
                                    ),
                                    Text(
                                      "Surprise Ba",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansMedium',
                                          fontSize: 11.sp,
                                          color: mGrey),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '€15.00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'PlusJakartaSansMedium',
                                      color: mGreyDisable,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '€4.99',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PlusJakartaSansSemiBold',
                                      color: mPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Price Row
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/ic_star.svg',
                                width: 16,
                                height: 16,
                                //color: isSelected ? selectedColor : color,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "4.5 (298)",
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansSemiBold',
                                    fontSize: 14,
                                    color: mGrey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Collection Time
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                "Collect today 4.30 PM - 5.30 PM",
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansMedium',
                                    fontSize: 12,
                                    color: mGreyDisable),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: mPrimaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Tomorrow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'PlusJakartaSansMedium',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Divider(),

                          const SizedBox(height: 8),
                          // Location
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:
                                Icon(Icons.location_on, color: mPrimaryColor),
                            trailing: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, storelocationpagesRoute);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: mPrimaryColor,
                                size: 16,
                              ),
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '10 Place de l\'Université Centre commercial...',
                                  style: TextStyle(
                                    color: mPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'PlusJakartaSansMedium',
                                  ),
                                ),
                                SizedBox(height: 6), // Adjust the gap here
                                Text(
                                  'More information about the store',
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSansRegular',
                                      fontSize: 12,
                                      color: mGrey),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          Divider(),
                          const SizedBox(height: 8),
                          // What You Could Get Section
                          const Text(
                            'What you could get',
                            style: TextStyle(
                                fontFamily: 'PlusJakartaSansSemiBold',
                                fontSize: 16,
                                color: mTextColor),
                          ),
                          const SizedBox(height: 8),
                          const SeeMoreText(
                              text:
                                  's simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                              maxLines: 3,
                              mTextColor: mGrey),

                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Meal',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Divider(),

                          // Ingredients & Allergens Section
                          const ListTile(
                            title: Text(
                              'Ingredients & allergens',
                              style: TextStyle(
                                  fontFamily: 'PlusJakartaSansSemiBold',
                                  fontSize: 16,
                                  color: mPrimaryColor),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: mPrimaryColor,
                            ),
                          ),

                          Divider(),
                          const SizedBox(height: 8),
                          // What Other People Are Saying Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'WHAT OTHER PEOPLE ARE SAYING',
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansSemiBold',
                                    fontSize: 16,
                                    color: mTextColor),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/ic_star.svg',
                                    width: 16,
                                    height: 16,
                                    //color: isSelected ? selectedColor : color,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "4.5 / 5.0",
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansSemiBold',
                                        fontSize: 20,
                                        color: mGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                              mButtonname: "Add to cart",
                              onpressed: () {},
                              mSelectcolor: mPrimaryColor,
                              mTextColor: Colors.white),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetProductdetailsNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigation(
        backgroundColor: Colors.white,
        showSelectedLables: true,
        showUnselectedLables: true,
        color: mGreyDisable,
        selectedColor: mPrimaryColor,
      ),
    );
  }
}

class SortText extends StatelessWidget {
  const SortText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Text(menuname,
        style: const TextStyle(
            fontFamily: 'PlusJakartaSansMedium', fontSize: 16, color: mGrey));
  }
}
