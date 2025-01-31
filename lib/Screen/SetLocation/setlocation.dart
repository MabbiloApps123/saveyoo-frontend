import 'dart:async';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:saveyoo/Screen/MapView/LocationPickerScreen.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_bloc.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_event.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class SetLocation extends StatefulWidget {
  SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  final TextEditingController emailController = TextEditingController();
  Position? _currentPosition;

  String mGPSLocation = "";
  double mGPSLocationLat = 0.00;
  double mGPSLocationLong = 0.00;
  String mGPSLocationHint = "";
  PickResult? getresult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationFromPreferences();
    BlocProvider.of<SetLocationBloc>(context).add(SetSetLocation());
    setState(() {
      loadPrefs();
      _getCurrentPosition();
    });
  }

  Future<void> getLocationFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the stored latitude and longitude
    double? latitude = prefs.getDouble(Constant.MLATITUDE);
    double? longitude = prefs.getDouble(Constant.MLONGITUDE);

    if (latitude != null && longitude != null) {
      print('Latitude: $latitude, Longitude: $longitude');
      // Use the retrieved values
    } else {
      print('No location data found');
    }
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
        .then((Position position) async {
      setState(
        () => _currentPosition = position,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(Constant.MLATITUDE, _currentPosition!.latitude);
      await prefs.setDouble(Constant.MLONGITUDE, _currentPosition!.longitude);
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SetLocationBloc, SetLocationState>(
        listener: (context, state) {
          if (state is SetLocationLoadedState) {}
        },
        builder: (context, state) {
          if (state is SetLocationLoadingState) {
            Loading(mLoaderGif).start(context);
            Text("");
          } else if (state is SetLocationLoadedState) {
            Loading.stop();
            return SafeArea(
                child: Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Stack(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Image.asset(
                          'assets/ic_location.png',
                          height: 200,
                          width: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(Languages.of(context)!.findbag,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: mTextColor,
                              fontFamily: "PlusJakartaSansSemiBold",
                            )),
                      ],
                    ),
                  ),

                  // Positioned button at the bottom
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 48,
                    child: Column(
                      children: [
                        PrimaryButton(
                          mButtonname: Languages.of(context)!.mycurrentlocation,
                          mFontSize: 15.sp,
                          onpressed: () {
                            if (_currentPosition == null) {
                              _getCurrentPosition();
                              ErrorToast(
                                  context: context,
                                  text: "Please wait.Getting your location");
                            } else {
                              // Navigator.pushReplacementNamed(
                              //     context, homescreenRoute);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                          latLng: LatLng(
                                              _currentPosition!.latitude,
                                              _currentPosition!.longitude),
                                          screenpostion: 0,
                                        )),
                              );
                            }
                          },
                          mSelectcolor: mPrimaryColor,
                          mTextColor: Colors.white,
                          mHeigth: 50,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // PrimaryButton(
                        //   mButtonname: Languages.of(context)!.mycurrentlocation,
                        //   mFontSize: 15.sp,
                        //   onpressed: () {
                        //     if (_currentPosition == null) {
                        //       _getCurrentPosition();
                        //       ErrorToast(
                        //           context: context,
                        //           text: "Please wait.Getting your location");
                        //     } else {
                        //       // Navigator.pushReplacementNamed(
                        //       //     context, homescreenRoute);
                        //
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => const MapView()),
                        //       );
                        //     }
                        //   },
                        //   mSelectcolor: Colors.white,
                        //   mTextColor: mPrimaryColor,
                        //   mHeigth: 50,
                        // ),
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // builder: (context) => const MapView()),
                                  builder: (context) =>
                                      const LocationPickerScreen()),
                            );

                            // Map results = await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const MapView()),
                            // );
                            // if (results != null &&
                            //     results.containsKey('MapLocation')) {
                            //   setState(() {
                            //     getresult = results['MapLocation'];
                            //     mGPSLocation = getresult!.formattedAddress!;
                            //     mGPSLocationLat =
                            //         getresult!.geometry!.location.lat;
                            //     mGPSLocationLong =
                            //         getresult!.geometry!.location.lng;
                            //   });
                            // }
                          },
                          child: Text(
                            Languages.of(context)!.selectlocation,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: mPrimaryColor,
                              fontFamily: "PlusJakartaSansSemiBold",
                            ),
                          ),
                        )
                        // GestureDetector(
                        //   onTap: () async {
                        //     ErrorToast(context: context, text: "text");
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const MapView()),
                        //     );
                        //
                        //     // // Handle the tap event
                        //     // //ErrorToast(context: context, text: "Enteryour");
                        //     Map results = await Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const MapView()),
                        //     );
                        //     if (results != null &&
                        //         results.containsKey('MapLocation')) {
                        //       setState(() {
                        //         getresult = results['MapLocation'];
                        //         mGPSLocation = getresult!.formattedAddress!;
                        //         mGPSLocationLat =
                        //             getresult!.geometry!.location.lat;
                        //         mGPSLocationLong =
                        //             getresult!.geometry!.location.lng;
                        //       });
                        //     }
                        //   },
                        //   child: Text(
                        //     Languages.of(context)!.selectlocation,
                        //     style: TextStyle(
                        //       fontSize: 15.sp,
                        //       color: mPrimaryColor,
                        //       fontFamily: "PlusJakartaSansSemiBold",
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ), // Replace with your child widget
            ));
          } else if (state is GetSetLocationNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
