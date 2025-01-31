import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saveyoo/Model/LoginResponse.dart';
import 'package:saveyoo/Model/LoginSuccessResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_bloc.dart';
import 'package:saveyoo/Screen/Browser/browser_screen.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_bloc.dart';
import 'package:saveyoo/Screen/Delivery/delivery_screen.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_bloc.dart';
import 'package:saveyoo/Screen/Favourites/favourites_screen.dart';
import 'package:saveyoo/Screen/Home/bloc/home_bloc.dart';
import 'package:saveyoo/Screen/Home/home.dart';
import 'package:saveyoo/Screen/HomeScreenBloc.dart';
import 'package:saveyoo/Screen/HomeScreenEvent.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_bloc.dart';
import 'package:saveyoo/Screen/Profile/profile_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:saveyoo/utils/pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  final LatLng latLng;
  final int screenpostion;

  HomeScreen({Key? key, required this.latLng, required this.screenpostion})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenBloc _homeBloc;

  StorageService storageService = StorageService();
  bool mIsLogin = false;
  // Position? _currentPosition;
  String _currentAddress = "";
  String mUserName = "Padhu";
  String mUserEmail = "Padhunpn@gmail.com";
  String mUserImage = "";
  final LoginRepo apiLoginRepo = LoginRepo();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double? _latitude;
  double? _longitude;
  double? Latitude = 0.0;
  double? Longitude = 0.0;
  String? range = "0";
  @override
  void initState() {
    super.initState();
    _homeBloc = HomeScreenBloc();
    _homeBloc.add(FetchDashboardInfo(
      widget.latLng.latitude.toString(),
      widget.latLng.longitude.toString(),
      "50",
    ));
    _loadLatLng();
    // _getAddressFromLatLng(widget.latLng.latitude!, widget.latLng.longitude!);
  }

  // Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
  //   await placemarkFromCoordinates(latitude, longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //           ' ${place.subLocality}, ${place.subAdministrativeArea}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> _loadLatLng() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedLatitude = prefs.getDouble(Constant.MLATITUDE);
    double? savedLongitude = prefs.getDouble(Constant.MLONGITUDE);

    Latitude = widget.latLng.latitude;
    Longitude = widget.latLng.longitude;
    range = prefs.getString(Constant.MRANGE);

    if (savedLatitude != null && savedLongitude != null) {
      setState(() {
        _latitude = savedLatitude;
        _longitude = savedLongitude;
      });
      _getAddressFromLatLng(savedLatitude, savedLongitude);
    } else {
      // If no saved lat/lng, set default values or fetch from a service
      setState(() {
        _latitude = 0.0; // Default latitude
        _longitude = 0.0; // Default longitude
      });
      _saveLatLngAndFetchAddress(_latitude!, _longitude!);
    }
  }

  Future<void> _saveLatLngAndFetchAddress(
      double latitude, double longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save new lat/long
    await prefs.setDouble(Constant.MLATITUDE, latitude);
    await prefs.setDouble(Constant.MLONGITUDE, longitude);

    // Fetch the address for the new location
    _getAddressFromLatLng(latitude, longitude);
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.subLocality}, ${place.subAdministrativeArea}';
      });
    } catch (e) {
      debugPrint("Failed to fetch address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,

        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            'assets/ic_menu.png',
            fit: BoxFit.contain,
            color: mPrimaryColor,
            height: 30,
          ),
        ),
        titleSpacing: 0.0, // Added this line
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              // Handle the tap event
              print('Text clicked');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Current Location",
                    style: TextStyle(
                      fontSize: 10,
                      color: mPrimaryColor,
                      fontFamily: "PlusJakartaSansRegular",
                    )),
                Text(_currentAddress,
                    style: const TextStyle(
                      fontSize: 12,
                      color: mPrimaryColor,
                      fontFamily: "PlusJakartaSansSemiBold",
                    )),
              ],
            ),
          ),
        ),

        backgroundColor: Colors.white, //elevation value of appbar
        foregroundColor: Colors.white,
        actions: [
          //actions widget in appbar
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, profileRoute);
            },
            icon: SvgPicture.asset(
              "assets/ic_navuser.svg",
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(
            width: 20,
          )
          //more widgets to place here
        ],
      ),
      body: Consumer<BottomNavigatorProvider>(
        builder: (ctx, item, child) {
          //switch (item.selectedIndex) {
          // if (item.selectedIndex != widget.screenpostion) {
          // }

          switch (widget.screenpostion) {
            case 0:
              return BlocProvider(
                  create: (_) => HomeBloc(mContext: context)
                    ..getDashboardInfo(
                        Latitude.toString(), Longitude.toString(), range!),
                  child: Homepage());
              break;

            case 1:
              return BlocProvider(
                  create: (_) => BrowserBloc(mContext: context),
                  child: const BrowserScreen());
              break;
            case 2:
              return BlocProvider(
                  create: (_) => DeliveryBloc(mContext: context),
                  child: DeliveryScreen());
              break;

            case 3:
              return BlocProvider(
                  create: (_) => ProfileBloc(mContext: context),
                  child: ProfileScreen());
              break;

            case 4:
              return BlocProvider(
                  create: (_) =>
                      FavouritesBloc(mContext: context)..getfavouriteInfo(),
                  child: FavouritesScreen());

              break;
            default:
              return BlocProvider(
                  create: (_) => HomeBloc(mContext: context),
                  child: Homepage());
              ;
              break;
          }
        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: Column(
          children: [
            // Fixed Header
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: mSecondaryColor),
              accountName: Text(
                mUserName,
                //  _currentPosition!.latitude.toString(),
                style: TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                mUserEmail,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50.0,
                backgroundImage:
                    const ExactAssetImage('assets/avathar.png', scale: 100),
                child: ClipOval(
                  child: (mUserImage.isNotEmpty)
                      ? Image.network(mUserImage,
                          width: 100, height: 100, fit: BoxFit.fill)
                      : Image.asset('assets/avathar.png',
                          width: 100, height: 100, fit: BoxFit.fill),
                ),
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(Languages.of(context)!.community,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 12.sp,
                              color: mGrey)),
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_invitefriend.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Inviteyourfriends),
                      onTap: () {},
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_recommended.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Recommendastore),
                      onTap: () {},
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading:
                          const sidemenuImage(menuicon: 'assets/nav_store.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Signupyourstore),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: mBorder,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(Languages.of(context)!.settings,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 12.sp,
                              color: mGrey)),
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_account.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Accountdetails),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_payment.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Paymentcards),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_voucher.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Vouchers),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const sidemenuImage(
                          menuicon: 'assets/nav_notification.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Notifications),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    Divider(
                      color: mBorder,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(Languages.of(context)!.support,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 12.sp,
                              color: mGrey)),
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading:
                          const sidemenuImage(menuicon: 'assets/nav_help.svg'),
                      title: SidemenuText(
                          menuname: Languages.of(context)!.Helpwithanorder),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    Divider(
                      color: mBorder,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(Languages.of(context)!.others,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 12.sp,
                              color: mGrey)),
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading:
                          const sidemenuImage(menuicon: 'assets/nav_legal.svg'),
                      title:
                          SidemenuText(menuname: Languages.of(context)!.Legal),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 0.3,
                    ),
                    Divider(
                      color: mBorder,
                    ),
                    ListTile(
                      minTileHeight: 50,
                      leading: const Icon(
                        Icons.logout,
                      ),
                      title:
                          SidemenuText(menuname: Languages.of(context)!.logout),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(Languages.of(context)!.logout),
                            content: Text(Languages.of(context)!.logoutmsg),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: Text(Languages.of(context)!.cancel),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Loading(mLoaderGif).start(context);
                                  apiLoginRepo.logout("").then((value) async {
                                    print(value);

                                    if (value is ApiSuccess) {
                                      Loading.stop();
                                      if (LoginSuccessResponse.fromJson(
                                                  value.data)
                                              .statusCode ==
                                          200) {
                                        storageService.deleteAllItem();

                                        Navigator.pushReplacementNamed(
                                            context, loginRoute);
                                      } else {
                                        ErrorToast(
                                            context: context,
                                            text: LoginResponse.fromJson(
                                                    value.data)
                                                .message);
                                      }
                                    } else if (value is ApiFailure) {
                                      Loading.stop();
                                    }
                                  });

                                  // ignore: use_build_context_synchronously
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: Text(Languages.of(context)!.logout),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
          backgroundColor: Colors.white,
          showSelectedLables: true,
          showUnselectedLables: true,
          color: mGreyDisable,
          selectedColor: mPrimaryColor,
          postion: widget.screenpostion),
    );
  }
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      menuicon,
      color: mTextColor,
      width: 18.sp,
      height: 18.sp,
      //color: isSelected ? selectedColor : color,
    );

    //   Image.asset(
    //   menuicon,
    //   height: 25,
    // );
  }
}

class SidemenuText extends StatelessWidget {
  const SidemenuText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Text(menuname,
        style: TextStyle(
            fontFamily: 'PlusJakartaSansMedium',
            fontSize: 13.sp,
            color: mTextColor));
  }
}
