import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Model/StoreProductResponse.dart';
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
import 'package:saveyoo/localization/language/languages.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class ProductdetailsScreen extends StatefulWidget {
  String mTitle;
  String latitude;
  String longitude;
  String radius;
  ProductdetailsScreen(
      {super.key,
      required this.mTitle,
      required this.latitude,
      required this.longitude,
      required this.radius});

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  var items = <Product>[];
  StoreProductData mGetStoreProduct = StoreProductData();

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<ProductdetailsBloc>(context).add(SetProductdetails());
    setState(() {
      loadPrefs();
    });
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
            mGetStoreProduct = state.mGetStoreProduct;
            Loading.stop();
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        mGetStoreProduct.product!.productImage,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      // Image.asset(
                      //   'assets/dummyy.jpg', // Replace with your image asset
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 200,
                      //   fit: BoxFit.cover,
                      // ),
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
                            if (widget.mTitle == "") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                          latLng: const LatLng(0.0, 0.0),
                                          screenpostion: 0,
                                        )),
                              );
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, seeallRoute,
                                  arguments: [
                                    widget.latitude,
                                    widget.longitude,
                                    widget.radius,
                                    widget.mTitle,
                                  ]);
                            }

                            // Navigator.pop(context); // Navigate back
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
                        top: 70,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '${mGetStoreProduct.quantity} left',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        left: 10,
                        right: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: CircleAvatar(
                                  radius: 20,
                                  child: ClipOval(
                                    child: Image.network(
                                      mGetStoreProduct.store!.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mGetStoreProduct.store!.name,
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansSemiBold',
                                        fontSize: 13.sp,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    mGetStoreProduct.store!.city,
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansMedium',
                                        fontSize: 11.sp,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  mGetStoreProduct.product!.name,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSansSemiBold',
                                      fontSize: 13.sp,
                                      color: mTextColor),
                                ),
                                Text(
                                  mGetStoreProduct.product!.category,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSansMedium',
                                      fontSize: 11.sp,
                                      color: mTextColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansMedium',
                                          fontSize: 11.sp,
                                          color: mGrey),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 2,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "12 KM",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansMedium',
                                          fontSize: 11.sp,
                                          color: mGrey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${Languages.of(context)!.rupess} ${mGetStoreProduct.originalPrice}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'PlusJakartaSansMedium',
                                        color: mGreyDisable,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${Languages.of(context)!.rupess} ${mGetStoreProduct.discountedPrice}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'PlusJakartaSansSemiBold',
                                        color: mPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: mPrimaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Collect  ${formatDate(mGetStoreProduct.pickupStartTime!)} -\n ${formatDate(mGetStoreProduct.pickupEndTime!)}",
                                  //"Collect today 4.30 PM - 5.30 PM",
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: mGreyFour,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Align at the top
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Center horizontally
                                  children: [
                                    Icon(Icons.location_on,
                                        color: mPrimaryColor),
                                  ],
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, storelocationpagesRoute,
                                      arguments: [
                                        mGetStoreProduct.product!.id,
                                        mGetStoreProduct.store!.id
                                      ]);
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: mPrimaryColor,
                                  size: 16,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${mGetStoreProduct.store!.street} ${mGetStoreProduct.store!.city}  \n ${mGetStoreProduct.store!.state} ${mGetStoreProduct.store!.postalCode}",
                                    style: const TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 14,
                                      fontFamily: 'PlusJakartaSansMedium',
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 6), // Adjust the gap here
                                  const Text(
                                    'More information about the store',
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansRegular',
                                        fontSize: 12,
                                        color: mGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: mGreyFour,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                SeeMoreText(
                                    text: mGetStoreProduct.product!.description,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: mGreyFour,
                          ),
                          ListTile(
                              title: const Text(
                                'Ingredients & allergens',
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansSemiBold',
                                    fontSize: 16,
                                    color: mPrimaryColor),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        contentPadding: EdgeInsets.all(16),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/ic_seeall_start.svg',
                                              width: 48,
                                              height: 48,
                                              //color: isSelected ? selectedColor : color,
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              Languages.of(context)!.alerttitle,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansSemiBold",
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              Languages.of(context)!.alertmsg,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            PrimaryButton(
                                              mButtonname:
                                                  Languages.of(context)!.gotit,
                                              onpressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              mSelectcolor: mPrimaryColor,
                                              mTextColor: Colors.white,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: mPrimaryColor,
                                ),
                              )),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: mGreyFour,
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'WHAT OTHER PEOPLE ARE SAYING',
                                style: TextStyle(
                                    fontFamily: 'PlusJakartaSansSemiBold',
                                    fontSize: 14,
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
                                        fontSize: 18,
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
                  ),
                ],
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
        postion: 10,
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
