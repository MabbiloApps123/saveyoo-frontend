import 'dart:async';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/screens.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  final TextEditingController emailController = TextEditingController();
  int onboardstatus = 0;
  Position? _currentPosition;
  bool getPermission = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SetSplash());
    setState(() {
      loadPrefs();
      // _checkLocationPermission(context);
    });
  }

  Future<void> loadPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    onboardstatus = prefs.getInt(Constant.MONBOARDSCREEN) ?? 0;
    mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // ignore: use_build_context_synchronously
  //     ErrorToast(
  //         context: context,
  //         text: 'Location services are disabled. Please enable the services');
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // ignore: use_build_context_synchronously
  //       ErrorToast(context: context, text: 'Location permissions are denied');
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // ignore: use_build_context_synchronously
  //     ErrorToast(
  //         context: context,
  //         text:
  //             'Location permissions are permanently denied, we cannot request permissions.');
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   _getCurrentPosition();
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   // final hasPermission = await _handleLocationPermission();
  //   // getPermission = hasPermission;
  //
  //   //if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(
  //       () => _currentPosition = position,
  //     );
  //     // ErrorToast(context: context, text: getPermission.toString());
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setDouble(Constant.MLATITUDE, _currentPosition!.latitude);
  //     await prefs.setDouble(Constant.MLONGITUDE, _currentPosition!.longitude);
  //   }).catchError((e) {});
  // }
  //
  // Future<void> _checkLocationPermission(BuildContext context) async {
  //   PermissionStatus status = await Permission.location.status;
  //
  //   if (status.isGranted) {
  //     // Navigate to the next page if permission is already granted
  //     _getCurrentPosition();
  //
  //     setState(() {
  //       OnLoadNext();
  //     });
  //   } else if (status.isDenied || status.isRestricted) {
  //     // Request permission
  //     PermissionStatus newStatus = await Permission.location.request();
  //
  //     if (newStatus.isGranted) {
  //       // Navigate to the next page if permission is granted
  //       _getCurrentPosition();
  //       setState(() {
  //         // ErrorToast(context: context, text: '123');
  //         OnLoadNext();
  //       });
  //     } else {
  //       ErrorToast(
  //           context: context,
  //           text: 'Location permission is required to proceed.');
  //       // Show a message if permission is denied
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   SnackBar(
  //       //     content: Text(
  //       //       'Location permission is required to proceed.',
  //       //       style: TextStyle(color: Colors.white),
  //       //     ),
  //       //     backgroundColor: Colors.red,
  //       //   ),
  //       // );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    //  Loading(mLoaderGif).start(context);
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            OnLoadNext();
            // Timer(const Duration(seconds: 2), () {
            //   // Navigate to the home screen after 3 seconds
            //   if (mIsLogin == null) {
            //     print("AAA");
            //     Navigator.pushReplacementNamed(context, onboardingRoute);
            //   } else {
            //     if (mIsLogin) {
            //       MaterialPageRoute(
            //           builder: (context) => HomeScreen(
            //             latLng: LatLng(_currentPosition!.latitude,
            //                 _currentPosition!.longitude),
            //             screenpostion: 0,
            //           ));
            //     } else {
            //       print("CCC");
            //       //  Navigator.pushReplacementNamed(context, onboardingRoute);
            //       if (onboardstatus == 0) {
            //         Navigator.pushReplacementNamed(context, onboardingRoute);
            //       } else {
            //         Navigator.pushReplacementNamed(context, setlocationRoute);
            //       }
            //     }
            //   }
            // });
          }
        },
        builder: (context, state) {
          if (state is SplashLoadingState) {
            //Loading(mLoaderGif).start(context);
          } else if (state is GetSplashInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Image(
                        image: AssetImage(
                          "assets/splashicon.png",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20.0,
                      child: Center(
                        child: Text(
                          "© ${getyear.year} Saveyoo1. All Rights Reserved",
                          style: const TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 18.0,
                              color: mPrimaryColor),
                          // TextStyle
                        ),
                      ))
                ],
              ),
            );
          } else if (state is GetSplashNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          } else {
            return SafeArea(
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Image(
                        image: AssetImage(
                          "assets/splashicon.png",
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 80.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: mPrimaryColor,
                        ),
                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20.0,
                      child: Center(
                        child: Text(
                          "© ${getyear.year} Saveyoo. All Rights Reserved",
                          style: const TextStyle(
                              fontFamily: 'PlusJakartaSansSemiBold',
                              fontSize: 18.0,
                              color: mPrimaryColor),
                          // TextStyle
                        ),
                      ))
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void OnLoadNext() {
    Timer(const Duration(seconds: 3), () {
      // Loading.stop();
      // Navigate to the home screen after 3 seconds

      if (mIsLogin == null) {
        print("AAA");
        Navigator.pushReplacementNamed(context, onboardingRoute);
      } else {
        if (mIsLogin) {
          //ErrorToast(context: context, text: mIsLogin.toString());
          // Navigator.pushReplacementNamed(context, setlocationRoute);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      latLng: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      screenpostion: 0,
                    )),
          );
          // MaterialPageRoute(
          //     builder: (context) => HomeScreen(
          //           latLng: LatLng(_currentPosition!.latitude,
          //               _currentPosition!.longitude),
          //           screenpostion: 0,
          //         ));
        } else {
          print("CCC");
          //  Navigator.pushReplacementNamed(context, onboardingRoute);
          if (onboardstatus == 0) {
            Navigator.pushReplacementNamed(context, onboardingRoute);
          } else {
            Navigator.pushReplacementNamed(context, setlocationRoute);
          }
        }
      }
    });
  }
}
