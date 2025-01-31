import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_event.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/screens.dart';
import '../../utils/pref_manager.dart';
import 'bloc/splash_bloc.dart';
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
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    onboardstatus = prefs.getInt(Constant.MONBOARDSCREEN) ?? 0;
    // mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  // @override
  // Widget build(BuildContext context) {
  //   var getyear = DateTime.now();
  //   //  Loading(mLoaderGif).start(context);
  //   return Scaffold(
  //     body: BlocConsumer<SplashBloc, SplashState>(
  //       listener: (context, state) {
  //         if (state is SplashLoadedState) {
  //           OnLoadNext();
  //
  //           // Navigator.pushReplacementNamed(context, loginRoute);
  //         }
  //       },
  //       builder: (context, state) {
  //         if (state is SplashLoadingState) {
  //           //Loading(mLoaderGif).start(context);
  //         } else if (state is GetSplashInfoSucessState) {
  //           Loading.stop();
  //           return SafeArea(
  //             child: Stack(
  //               children: [
  //                 const Align(
  //                   alignment: Alignment.center,
  //                   child: Padding(
  //                     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                     child: Image(
  //                       image: AssetImage(
  //                         "assets/splashicon.png",
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 20.0,
  //                     child: Center(
  //                       child: Text(
  //                         "© ${getyear.year} Saveyoo1. All Rights Reserved",
  //                         style: TextStyle(
  //                             fontFamily: 'PlusJakartaSansSemiBold',
  //                             fontSize: 16.sp,
  //                             color: mPrimaryColor),
  //                         // TextStyle
  //                       ),
  //                     ))
  //               ],
  //             ),
  //           );
  //         } else if (state is GetSplashNointernetState) {
  //           Loading.stop();
  //           return SafeArea(child: NoInternet());
  //         } else {
  //           return SafeArea(
  //             child: Stack(
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Padding(
  //                     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                     child: Image(
  //                       height: MediaQuery.of(context).size.height / 3,
  //                       width: MediaQuery.of(context).size.width / 2,
  //                       image: AssetImage(
  //                         "assets/app_icon.png",
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const Positioned(
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 80.0,
  //                     child: Center(
  //                       child: CircularProgressIndicator(
  //                         color: mPrimaryColor,
  //                       ),
  //                     )),
  //                 Positioned(
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 20.0,
  //                     child: Center(
  //                       child: Text(
  //                         "© ${getyear.year} Saveyoo. All Rights Reserved",
  //                         style: const TextStyle(
  //                             fontFamily: 'PlusJakartaSansSemiBold',
  //                             fontSize: 18.0,
  //                             color: mPrimaryColor),
  //                         // TextStyle
  //                       ),
  //                     ))
  //               ],
  //             ),
  //           );
  //         }
  //         return Container();
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    return BlocProvider(
      create: (_) =>
          SplashBloc(mContext: context)..add(CheckLocationPermissionEvent()),
      child: Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccess) {
              OnLoadNext();
            } else if (state is SplashPermissionDenied) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is SplashLoading) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Image.asset('assets/saveyo.gif')
                          // Image(
                          //   height: MediaQuery.of(context).size.height / 3,
                          //   width: MediaQuery.of(context).size.width / 2,
                          //   image:
                          //   const AssetImage(
                          //     "assets/app_icon.png",
                          //   ),
                          // ),
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
            } else if (state is SplashPermissionDenied) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SplashBloc>()
                            .add(CheckLocationPermissionEvent());
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Image.asset('assets/saveyo.gif')
                        // Image(
                        //   height: MediaQuery.of(context).size.height / 3,
                        //   width: MediaQuery.of(context).size.width / 2,
                        //   image: const AssetImage(
                        //     "assets/app_icon.png",
                        //   ),
                        // ),
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
          },
        ),
      ),
    );
  }

  void OnLoadNext() {
    Timer(const Duration(seconds: 3), () {
      // Loading.stop();

      if (mIsLogin == null) {
        print("AAA");
        Navigator.pushReplacementNamed(context, onboardingRoute);
      } else {
        // Navigator.pushReplacementNamed(context, onboardingRoute);
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
