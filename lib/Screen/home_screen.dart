import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_bloc.dart';
import 'package:saveyoo/Screen/Browse/browse_screen.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_bloc.dart';
import 'package:saveyoo/Screen/Delivery/delivery_screen.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_bloc.dart';
import 'package:saveyoo/Screen/Favourites/favourites_screen.dart';
import 'package:saveyoo/Screen/Home/bloc/home_bloc.dart';
import 'package:saveyoo/Screen/Home/home.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_bloc.dart';
import 'package:saveyoo/Screen/Profile/profile_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/localization/language/languages.dart';

import '../../utils/pref_manager.dart';

class HomeScreen extends StatefulWidget {
  LatLng latLng;
  int screenpostion;
  HomeScreen({super.key, required this.latLng, required this.screenpostion});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  Position? _currentPosition;
  String _currentAddress = "";
  String mUserName = "";
  String mUserEmail = "";
  String mUserImage = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      loadPrefs();
      _getCurrentPosition();
    });
  }

  Future<void> loadPrefs() async {
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // setState(
      //   () => _currentPosition = position,
      // );
      setState(() {
        _currentPosition = position;
        // lat = _currentPosition!.latitude;
        //long = _currentPosition!.longitude;
      });

      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            ' ${place.subLocality}, ${place.subAdministrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Map<int, Color> color = {
    50: const Color.fromRGBO(250, 202, 88, .1),
    100: const Color.fromRGBO(250, 202, 88, .2),
    200: const Color.fromRGBO(250, 202, 88, .3),
    300: const Color.fromRGBO(250, 202, 88, .4),
    400: const Color.fromRGBO(250, 202, 88, .5),
    500: const Color.fromRGBO(250, 202, 88, .6),
    600: const Color.fromRGBO(250, 202, 88, .7),
    700: const Color.fromRGBO(250, 202, 88, .8),
    800: const Color.fromRGBO(250, 202, 88, .9),
    900: const Color.fromRGBO(250, 202, 88, 1),
  };

  Future<void> _showMyDialog(BuildContext context, String place) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(place),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFFFACA58, color);
    return Scaffold(
      backgroundColor: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_currentAddress,
                    style: const TextStyle(
                      fontSize: 14,
                      color: mPrimaryColor,
                      fontFamily: "PlusJakartaSansSemiBold",
                    )),
                Text("with in 14 Km",
                    style: const TextStyle(
                      fontSize: 12,
                      color: mPrimaryColor,
                      fontFamily: "PlusJakartaSansRegular",
                    ))
              ],
            ),
          ),
        ),

        backgroundColor: Colors.white, //elevation value of appbar
        foregroundColor: Colors.white,
        actions: const [
          //actions widget in appbar

          //more widgets to place here
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: mSecondaryColor),
              accountName: Text(
                mUserName,
                //  _currentPosition!.latitude.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                mUserEmail,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
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

            // Divider(), //here is a divider
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(Languages.of(context)!.community,
                  style: const TextStyle(
                      fontFamily: 'PlusJakartaSansMedium',
                      fontSize: 18,
                      color: mGrey)),
            ),
            ListTile(
              leading:
                  const sidemenuImage(menuicon: 'assets/nav_invitefriend.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.Inviteyourfriends),
              onTap: () {},
            ),

            ListTile(
              leading:
                  const sidemenuImage(menuicon: 'assets/nav_recommended.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.Recommendastore),
              onTap: () {},
            ),

            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_store.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.Signupyourstore),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),

            const Divider(),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(Languages.of(context)!.settings,
                  style: const TextStyle(
                      fontFamily: 'PlusJakartaSansMedium',
                      fontSize: 18,
                      color: mGrey)),
            ),

            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_account.svg'),
              title:
                  SidemenuText(menuname: Languages.of(context)!.Accountdetails),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_payment.svg'),
              title:
                  SidemenuText(menuname: Languages.of(context)!.Paymentcards),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_voucher.svg'),
              title: SidemenuText(menuname: Languages.of(context)!.Vouchers),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading:
                  const sidemenuImage(menuicon: 'assets/nav_notification.svg'),
              title:
                  SidemenuText(menuname: Languages.of(context)!.Notifications),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            const Divider(),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(Languages.of(context)!.support,
                  style: const TextStyle(
                      fontFamily: 'PlusJakartaSansMedium',
                      fontSize: 18,
                      color: mGrey)),
            ),

            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_help.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.Helpwithanorder),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_gowork.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.HowTooGoodToGoworks),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_join.svg'),
              title: SidemenuText(
                  menuname: Languages.of(context)!.JoinTooGoodToGo),
              onTap: () {},
            ),

            const Divider(),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(Languages.of(context)!.others,
                  style: const TextStyle(
                      fontFamily: 'PlusJakartaSansMedium',
                      fontSize: 18,
                      color: mGrey)),
            ),

            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_hidden.svg'),
              title:
                  SidemenuText(menuname: Languages.of(context)!.HiddenStores),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),
            ListTile(
              leading: const sidemenuImage(menuicon: 'assets/nav_legal.svg'),
              title: SidemenuText(menuname: Languages.of(context)!.Legal),
              onTap: () {},
            ),
            const SizedBox(
              height: 0.3,
            ),

            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: SidemenuText(menuname: Languages.of(context)!.logout),
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (ctx) => AlertDialog(
                //     title: Text(Languages.of(context)!.appName),
                //     content: Text(Languages.of(context)!.appName),
                //     actions: <Widget>[
                //       TextButton(
                //         onPressed: () {
                //           Navigator.of(ctx).pop();
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(14),
                //           child: Text(Languages.of(context)!.appName),
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: () async {
                //           storageService.deleteAllItem();
                //
                //           // ignore: use_build_context_synchronously
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(14),
                //           child: Text(Languages.of(context)!.appName),
                //         ),
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: Center(
        child: Consumer<BottomNavigatorProvider>(
          builder: (ctx, item, child) {
            // switch (item.selectedIndex) {
            switch (widget.screenpostion) {
              case 0:
                return BlocProvider(
                    create: (_) => HomeBloc(mContext: context),
                    child: Homepage());
                break;
              case 1:
                return BlocProvider(
                    create: (_) => BrowseBloc(mContext: context),
                    child: BrowseScreen());
                break;
              case 2:
                return BlocProvider(
                    create: (_) => DeliveryBloc(mContext: context),
                    child: DeliveryScreen());
                break;

              case 3:
                return BlocProvider(
                    create: (_) => FavouritesBloc(mContext: context),
                    child: FavouritesScreen());

              case 4:
                return BlocProvider(
                    create: (_) => ProfileBloc(mContext: context),
                    child: ProfileScreen());
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
      width: 24,
      height: 24,
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
            fontFamily: 'PlusJakartaSansRegular',
            fontSize: 15,
            color: mGreyDisable));
  }
}
