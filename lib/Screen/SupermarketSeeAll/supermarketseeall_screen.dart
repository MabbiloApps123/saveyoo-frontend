import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/StoreResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_bloc.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_event.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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

  var mStoreList = <StoreResponseDatum>[];

  double? Latitude = 0.0;
  double? Longitude = 0.0;
  String? range = "0";

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<SupermarketSeeallBloc>(context).add(SetSupermarketSeeall());
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Latitude = prefs.getDouble(Constant.MLATITUDE);
    Longitude = prefs.getDouble(Constant.MLONGITUDE);
    range = prefs.getString(Constant.MRANGE);
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        latLng:
                            LatLng(Latitude!.toDouble(), Longitude!.toDouble()),
                        screenpostion: 0,
                      )),
            );
          },
        ),
        backgroundColor: mPrimaryColor,
        title: Text(
          Languages.of(context)!.supermarkets,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontFamily: "PlusJakartaSansSemiBold",
          ),
        ),
        centerTitle: false,
      ),
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
            mStoreList = state.mStoreList;
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
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
                            width: 24,
                            height: 24,
                            //color: isSelected ? selectedColor : color,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'These are the supermarkets near you. Choose a store and see all the Surprise Bags they have.',
                              style: TextStyle(
                                  fontSize: 12.sp,
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
                        itemCount: mStoreList.length,
                        itemBuilder: (context, index) {
                          final restaurant = mStoreList[index];
                          return Column(
                            children: [
                              SupermarketCard(
                                storelist: restaurant,
                              ),
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
        postion: 10,
      ),
    );
  }
}

class SupermarketCard extends StatelessWidget {
  final StoreResponseDatum storelist;

  const SupermarketCard({
    Key? key,
    required this.storelist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, storelocationpagesRoute,
              arguments: [storelist.id, 0]);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
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
                      'assets/dummyy.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned Logo
                  Positioned(
                    top: 15,
                    left: 50,
                    // Adjust this value to center horizontally
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        storelist.imageUrl,
                      ),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              // Supermarket Image

              const SizedBox(width: 40),
              // Text and Logo Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Logo Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            storelist.name,
                            style: TextStyle(
                                fontFamily: 'PlusJakartaSansSemiBold',
                                fontSize: 14.sp,
                                color: mTextColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Location
                    Text(
                      storelist.city,
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansRegular',
                          fontSize: 12.sp,
                          color: mGrey),
                    ),
                    const SizedBox(height: 4),
                    // Distance
                    Text(
                      "4 KM",
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansRegular',
                          fontSize: 12.sp,
                          color: mTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

        // Container(
        //   width: size.width,
        //   margin: const EdgeInsets.only(right: 16),
        //   padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: mBorder, width: 1),
        //     borderRadius: BorderRadius.circular(8.0),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Stack(
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(8),
        //             child:
        //                 // Image.asset(
        //                 //   'assets/dummy.jpeg',
        //                 //   fit: BoxFit.cover,
        //                 //   width: size.width,
        //                 //   height: 110,
        //                 // )
        //
        //                 Image.network(
        //               restaurant.productImage,
        //               height: 150,
        //               width: size.width,
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //           Positioned(
        //             left: 8.0,
        //             top: 10,
        //             child: Container(
        //               padding: const EdgeInsets.all(
        //                   3), // Add padding inside the container
        //               decoration: BoxDecoration(
        //                 color: mPrimaryColor, // Background color
        //                 borderRadius: BorderRadius.circular(4), // Rounded corners
        //               ),
        //               child: Text(
        //                 '${restaurant.quantity} items available',
        //                 style: TextStyle(
        //                     fontFamily: 'PlusJakartaSansSemiBold',
        //                     fontSize: 9.sp,
        //                     color: Colors.white),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             right: 8.0,
        //             child: Chip(
        //               side: BorderSide.none,
        //               labelPadding: EdgeInsets.zero,
        //               backgroundColor:
        //                   (restaurant.isFavourite) ? mWhiteColor : mPrimaryColor,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius:
        //                     BorderRadius.circular(30.0), // Custom radius
        //               ),
        //               label:
        //                   // SvgPicture.asset(
        //                   //   'assets/ic_unfavorite.svg',
        //                   //   width: 20,
        //                   //   height: 20,
        //                   //   //color: isSelected ? selectedColor : color,
        //                   // )
        //                   (restaurant.isFavourite)
        //                       ? SvgPicture.asset(
        //                           'assets/ic_favorite.svg',
        //                           width: 24,
        //                           height: 24,
        //                         )
        //                       : SvgPicture.asset(
        //                           'assets/ic_unfavorite.svg',
        //                           width: 24,
        //                           height: 24,
        //                           //color: isSelected ? selectedColor : color,
        //                         ),
        //             ),
        //           ),
        //           // Positioned(
        //           //   bottom: 10,
        //           //   left: 10,
        //           //   child: Row(
        //           //     children: [
        //           //       CircleAvatar(
        //           //         radius: 30,
        //           //         child: CircleAvatar(
        //           //           radius: 30,
        //           //           child: ClipOval(
        //           //             child: Image.network(
        //           //               "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        //           //               fit: BoxFit.cover,
        //           //             ),
        //           //           ),
        //           //         ),
        //           //       ),
        //           //       const SizedBox(width: 10),
        //           //       const Column(
        //           //         mainAxisAlignment: MainAxisAlignment.center,
        //           //         crossAxisAlignment: CrossAxisAlignment.start,
        //           //         children: [
        //           //           Text("Carrefour Market",
        //           //               maxLines: 1,
        //           //               overflow: TextOverflow.ellipsis,
        //           //               style: TextStyle(
        //           //                   fontFamily: 'PlusJakartaSansMedium',
        //           //                   fontSize: 16,
        //           //                   color: Colors.black)),
        //           //           Text("Tervuren",
        //           //               maxLines: 1,
        //           //               overflow: TextOverflow.ellipsis,
        //           //               style: TextStyle(
        //           //                   fontFamily: 'PlusJakartaSansMedium',
        //           //                   fontSize: 16,
        //           //                   color: Colors.black))
        //           //         ],
        //           //       )
        //           //     ],
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //       Padding(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             CircleAvatar(
        //               radius: 20,
        //               child: CircleAvatar(
        //                 radius: 20,
        //                 child: ClipOval(
        //                   child: Image.network(
        //                     restaurant.store.imageUrl,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               width: 5,
        //             ),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     restaurant.store.name,
        //                     style: TextStyle(
        //                         fontFamily: 'PlusJakartaSansSemiBold',
        //                         fontSize: 13.sp,
        //                         color: mGrey),
        //                   ),
        //                   Text(
        //                     restaurant.product,
        //                     style: TextStyle(
        //                         fontFamily: 'PlusJakartaSansMedium',
        //                         fontSize: 11.sp,
        //                         color: mGrey),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Padding(
        //           padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
        //           child: Row(
        //             children: [
        //               // First column
        //               Expanded(
        //                 flex: 3, // Takes 3 parts of the space
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       "Collect today ${formatDateToTime(restaurant.pickupStartTime)} - ${formatDateToTime(restaurant.pickupEndTime)}",
        //                       style: TextStyle(
        //                           fontFamily: 'PlusJakartaSansRegular',
        //                           fontSize: 12,
        //                           color: mGreyDisable),
        //                     ),
        //                     const SizedBox(
        //                       height: 5,
        //                     ),
        //                     Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       children: [
        //                         SvgPicture.asset(
        //                           'assets/ic_star.svg',
        //                           width: 16,
        //                           height: 16,
        //                           //color: isSelected ? selectedColor : color,
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Text(
        //                           restaurant.ratings.toString(),
        //                           style: TextStyle(
        //                               fontFamily: 'PlusJakartaSansMedium',
        //                               fontSize: 11.sp,
        //                               color: mGrey),
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Container(
        //                           color: Colors.grey,
        //                           width: 2,
        //                           height: 15,
        //                         ),
        //                         const SizedBox(
        //                           width: 8,
        //                         ),
        //                         Text(
        //                           "${restaurant.distance} KM",
        //                           style: TextStyle(
        //                               fontFamily: 'PlusJakartaSansMedium',
        //                               fontSize: 11.sp,
        //                               color: mGrey),
        //                         ),
        //                       ],
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               // Second column
        //               Expanded(
        //                 flex: 1, // Takes 1 part of the space
        //                 child: Column(
        //                   children: [
        //                     Text(
        //                       Languages.of(context)!.rupess +
        //                           restaurant.originalPrice.toString(),
        //                       style: TextStyle(
        //                         fontSize: 10.sp,
        //                         fontFamily: 'PlusJakartaSansRegular',
        //                         color: mGreyDisable,
        //                         decoration: TextDecoration.lineThrough,
        //                       ),
        //                     ),
        //                     const SizedBox(width: 4),
        //                     Text(
        //                       Languages.of(context)!.rupess +
        //                           restaurant.discountedPrice.toString(),
        //                       style: TextStyle(
        //                         fontSize: 12.sp,
        //                         fontFamily: 'PlusJakartaSansSemiBold',
        //                         color: mPrimaryColor,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ))
        //     ],
        //   ),
        // ),
        );
  }
}
