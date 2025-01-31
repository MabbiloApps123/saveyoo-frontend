import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/SeeallResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/SeeAll/SeeallPreviewCard.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_bloc.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_event.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class SeeallScreen extends StatefulWidget {
  String mTitle;
  String latitude;
  String longitude;
  String radius;
  SeeallScreen(
      {super.key,
      required this.mTitle,
      required this.latitude,
      required this.longitude,
      required this.radius});

  @override
  State<SeeallScreen> createState() => _SeeallScreenState();
}

class _SeeallScreenState extends State<SeeallScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  List<Datum> mSeeallData = [];

  double? Latitude = 0.0;
  double? Longitude = 0.0;
  String? range = "0";

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<SeeallBloc>(context).add(SetSeeall());
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
          widget.mTitle == "just_for_you"
              ? Languages.of(context)!.JustforYou
              : widget.mTitle == "last_chance_deals"
                  ? Languages.of(context)!.latechange
                  : widget.mTitle == "available_now"
                      ? Languages.of(context)!.availablenow
                      : widget.mTitle == "dinnertime_deals"
                          ? Languages.of(context)!.DinnertimeDeals
                          : Languages.of(context)!.JustforYou,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontFamily: "PlusJakartaSansSemiBold",
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<SeeallBloc, SeeallState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is SeeallLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetSeeallInfoSucessState) {
            mSeeallData = state.mSeeallData;
            Loading.stop();
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
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
                          Text(
                            Languages.of(context)!.seeallmsg,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "PlusJakartaSansMedium",
                                color: mPrimaryColor),
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
                        itemCount: mSeeallData.length,
                        itemBuilder: (context, index) {
                          final restaurant = mSeeallData[index];
                          return Column(
                            children: [
                              SeeallPreviewCard(
                                  restaurant: restaurant!,
                                  mTitle: widget.mTitle,
                                  latitude: widget.latitude,
                                  longitude: widget.longitude,
                                  radius: widget.radius),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is GetSeeallNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          // return Container();
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
