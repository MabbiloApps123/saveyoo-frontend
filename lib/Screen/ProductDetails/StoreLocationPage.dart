import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Model/StoreDetailsResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_bloc.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_event.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class StoreLocationPage extends StatefulWidget {
  final String mStoreId;
  final String mProductId;
  const StoreLocationPage({
    super.key,
    required this.mStoreId,
    required this.mProductId,
  });

  @override
  State<StoreLocationPage> createState() => _StoreLocationPageState();
}

class _StoreLocationPageState extends State<StoreLocationPage> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  var items = <Product>[];
  List<Datum> mStoreDetailsData = [];

  double? Latitude = 0.0;
  double? Longitude = 0.0;
  String? range = "0";

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<ProductdetailsBloc>(context).add(SetProductdetails());
    setState(() {
      loadPrefs();
    });
    // loadUsers();
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
      backgroundColor: mCardBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: mPrimaryColor,
            size: 30,
          ),
          onPressed: () async {
            // ErrorToast(context: context, text: widget.mProductId);
            if (int.tryParse(widget.mProductId) == -1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          latLng: LatLng(
                              Latitude!.toDouble(), Longitude!.toDouble()),
                          screenpostion: 0,
                        )),
              );
              // Navigator.pushReplacementNamed(context, supermarketseeallRoute);
            } else if (int.tryParse(widget.mProductId) == 0) {
              Navigator.pushReplacementNamed(context, supermarketseeallRoute);
            } else {
              Navigator.pushReplacementNamed(context, productdetailsRoute,
                  arguments: [widget.mProductId, "", "", "", ""]);
            }
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Store Info',
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<ProductdetailsBloc, ProductdetailsState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is StoreLocationLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetStoreLocationInfoSucessState) {
            mStoreDetailsData = state.mStoreDetailsData;
            Loading.stop();
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: ClipOval(
                                      child: Image.network(
                                        mStoreDetailsData[0].store.imageUrl ??
                                            "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mStoreDetailsData[0].store.name ?? "",
                                        style: TextStyle(
                                            fontFamily:
                                                'PlusJakartaSansSemiBold',
                                            fontSize: 13.sp,
                                            color: mGrey),
                                      ),
                                      Text(
                                        mStoreDetailsData[0].store.city ?? "",
                                        style: TextStyle(
                                            fontFamily: 'PlusJakartaSansMedium',
                                            fontSize: 11.sp,
                                            color: mGrey),
                                      ),
                                      Text(
                                        "4 KM",
                                        style: TextStyle(
                                            fontFamily: 'PlusJakartaSansMedium',
                                            fontSize: 11.sp,
                                            color: mGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 1,
                            color: mBorder,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.location_on,
                                  color: mPrimaryColor),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //"${mStoreDetailsData[0].store!.street} ${mStoreDetailsData[0].store!.city}  \n ${mStoreDetailsData[0].store!.state} ${mStoreDetailsData[0].store!.postalCode}",
                                    "${mStoreDetailsData[0].store!.street} ${mStoreDetailsData[0].store!.city}  ",
                                    style: const TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 16,
                                      fontFamily: 'PlusJakartaSansMedium',
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 6), // Adjust the gap here
                                  const Text(
                                    'Click for directions',
                                    style: TextStyle(
                                        fontFamily: 'PlusJakartaSansRegular',
                                        fontSize: 12,
                                        color: mGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildSurpriseBagsSection(context),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildAboutSection(context),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildMapSection(context),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildMoreInfoSection(context),
                    )
                  ],
                ),
              ),
            );
          } else if (state is GetStoreLocationNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSurpriseBagsSection(BuildContext context) {
    if (mStoreDetailsData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Text('No surprise bags available',
            style: TextStyle(
                fontFamily: 'PlusJakartaSansSemiBold',
                fontSize: 13.sp,
                color: mGrey)),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Surprise Bags from this store',
              style: TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 13.sp,
                  color: mGrey)),
          const SizedBox(height: 16),
          Container(
              height: 200,
              child: SizedBox(
                height: 2 * 200, // Adjust based on item height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mStoreDetailsData.length,
                  itemBuilder: (context, index) {
                    final bag = mStoreDetailsData[index];
                    return Column(
                      children: [
                        // First Row Item
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 8, bottom: 8),
                          child: _buildSurpriseBagItem(
                            bag.name,
                            "${formatDate(bag.pickupStartTime)} \n${formatDate(bag.pickupEndTime)}",
                            bag.discountedPrice,
                            bag.productImage,
                          ),
                        ),

                        // Second Row Item (next index)
                        if (index + 1 < mStoreDetailsData.length)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 8, top: 8),
                            child: _buildSurpriseBagItem(
                              mStoreDetailsData[index + 1].name,
                              "${formatDate(mStoreDetailsData[index + 1].pickupStartTime)} \n${formatDate(mStoreDetailsData[index + 1].pickupEndTime)}",
                              mStoreDetailsData[index + 1].discountedPrice,
                              mStoreDetailsData[index + 1].productImage,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              )
              // ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: mStoreDetailsData.length,
              //   itemBuilder: (context, index) {
              //     final bag = mStoreDetailsData[index];
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 16, left: 16),
              //       child: _buildSurpriseBagItem(
              //         bag.name,
              //         "${formatDate(bag.pickupStartTime)} \n${formatDate(bag.pickupEndTime)}",
              //         bag.discountedPrice,
              //         bag.productImage,
              //       ),
              //     );
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  Widget _buildSurpriseBagItem(
      String title, String time, String price, String imagePath) {
    return Row(
      children: [
        // CircleAvatar(
        //   radius: 25,
        //   child: CircleAvatar(
        //     radius: 25,
        //     child: ClipOval(
        //       child: Image.network(
        //         imagePath,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: 70,
          height: 50,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontFamily: 'PlusJakartaSansSemiBold',
                    fontSize: 11.sp,
                    color: mGrey)),
            const SizedBox(width: 4),
            Text(time,
                style: TextStyle(
                    fontFamily: 'PlusJakartaSansRegular',
                    fontSize: 9.sp,
                    color: Colors.grey)),
            const SizedBox(width: 4),
            Text("${Languages.of(context)!.rupess} $price",
                style: TextStyle(
                  fontFamily: 'PlusJakartaSansRegular',
                  fontSize: 10.sp,
                )),
          ],
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_ios, size: 20, color: mPrimaryColor)
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              fontFamily: 'PlusJakartaSansSemiBold',
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mStoreDetailsData[0].store!.about,
            style: TextStyle(
              fontFamily: 'PlusJakartaSansRegular',
              fontSize: 11.sp,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge('3+ years', 'Fighting food waste'),
              _buildBadge('7,500+', 'Meals saved'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String title, String subtitle) {
    return Column(
      children: [
        Icon(Icons.verified, size: 40, color: Colors.green),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(50.717488, 4.607621),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('storeLocation'),
            position: LatLng(50.717488, 4.607621),
          ),
        },
      ),
    );
  }

  Widget _buildMoreInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Info',
            style: TextStyle(
              fontFamily: 'PlusJakartaSansSemiBold',
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.public, size: 20, color: Colors.grey),
              TextButton(
                onPressed: () {},
                child: Text(mStoreDetailsData[0].store!.webUrl,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSansRegular',
                      fontSize: 11.sp,
                    )),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.info, size: 20, color: Colors.grey),
              const SizedBox(width: 10),
              Text('VAT no : ${mStoreDetailsData[0].store!.vat}',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSansRegular',
                    fontSize: 11.sp,
                  )),
            ],
          )
        ],
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
