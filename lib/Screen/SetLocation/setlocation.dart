import 'dart:async';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saveyoo/Network/di.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SetLocationBloc>(context).add(SetSetLocation());
    setState(() {
      loadPrefs();
      _getCurrentPosition();
    });
  }

  Future<void> loadPrefs() async {
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  Future<void> _checkLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      // Navigate to the next page if permission is already granted
      _getCurrentPosition();

      setState(() {});
    } else if (status.isDenied || status.isRestricted) {
      // Request permission
      PermissionStatus newStatus = await Permission.location.request();

      if (newStatus.isGranted) {
        // Navigate to the next page if permission is granted
        _getCurrentPosition();
        setState(() {});
      } else {
        ErrorToast(
            context: context,
            text: 'Location permission is required to proceed.');
      }
    }
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(
        () => _currentPosition = position,
      );
      // ErrorToast(context: context, text: _currentPosition!.latitude.toString());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(Constant.MLATITUDE, _currentPosition!.latitude);
      await prefs.setDouble(Constant.MLONGITUDE, _currentPosition!.longitude);
      sl<StorageService>()
          .setDouble(Constant.MLATITUDE, _currentPosition!.latitude);

      sl<StorageService>()
          .setDouble(Constant.MLONGITUDE, _currentPosition!.longitude);
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
                            style: const TextStyle(
                              fontSize: 22,
                              color: mPrimaryColor,
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
                          onpressed: () {
                            if (_currentPosition == null) {
                              SucessToast(
                                  context: context,
                                  text: "Please wait.Getting your location");
                            } else {
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle the tap event
                            print('Text tapped');
                          },
                          child: Text(
                            Languages.of(context)!.selectlocation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: mPrimaryColor,
                              fontFamily: "PlusJakartaSansSemiBold",
                            ),
                          ),
                        )
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
