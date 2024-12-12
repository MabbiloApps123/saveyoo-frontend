import 'dart:convert';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_bloc.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_event.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/localization/language/languages.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class SupermarketSeeallScreen extends StatefulWidget {
  const SupermarketSeeallScreen({super.key});

  @override
  State<SupermarketSeeallScreen> createState() =>
      _SupermarketSeeallScreenState();
}

class _SupermarketSeeallScreenState extends State<SupermarketSeeallScreen> {
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
    BlocProvider.of<SupermarketSeeallBloc>(context).add(SetSupermarketSeeall());
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
      body: BlocConsumer<SupermarketSeeallBloc, SupermarketSeeallState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is SupermarketSeeallLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetSupermarketSeeallInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            size: 30,
                            color: Colors.black,
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
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Languages.of(context)!.supermarkets,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "PlusJakartaSansSemiBold",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(
                          20, 5, 10, 5), // Inner padding
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        border: Border.all(
                          color: mBorder, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/ic_seeall_start.svg',
                            width: 30,
                            height: 30,
                            //color: isSelected ? selectedColor : color,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'These are the supermarkets near you. Choose a store and see all the Surprise Bags they have.',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "PlusJakartaSansMedium",
                                  color: mPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final restaurant = items[index];
                          return const Column(
                            children: [
                              SupermarketCard(
                                imageUrl: 'assets/dummy.jpeg',
                                logoUrl: 'assets/dummyy.jpg',
                                title: 'Carrefour Hypermarc...',
                                location: 'Bierges',
                                distance: '1.4 km',
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is GetSupermarketSeeallNointernetState) {
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

class SupermarketCard extends StatelessWidget {
  final String imageUrl;
  final String logoUrl;
  final String title;
  final String location;
  final String distance;

  const SupermarketCard({
    Key? key,
    required this.imageUrl,
    required this.logoUrl,
    required this.title,
    required this.location,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      // padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: mBorder, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows the CircleAvatar to overflow
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  height: 100,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned Logo
              Positioned(
                top: 25,
                left: 50,
                // Adjust this value to center horizontally
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/avathar.png"),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
          // Supermarket Image

          const SizedBox(width: 50),
          // Text and Logo Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Logo Row
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        "Store Name",
                        style: TextStyle(
                            fontFamily: 'PlusJakartaSansSemiBold',
                            fontSize: 16,
                            color: mTextColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 4),
                // Location
                Text(
                  "Chennai",
                  style: TextStyle(
                      fontFamily: 'PlusJakartaSansMedium',
                      fontSize: 14,
                      color: mGrey),
                ),
                const SizedBox(height: 4),
                // Distance
                const Text(
                  "4 KM",
                  style: TextStyle(
                      fontFamily: 'PlusJakartaSansRegular',
                      fontSize: 14,
                      color: mTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
