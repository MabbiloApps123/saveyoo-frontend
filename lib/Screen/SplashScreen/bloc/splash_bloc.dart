import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_event.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_state.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  var mContext;

  SplashBloc({required this.mContext}) : super(SplashInitial()) {
    on<CheckLocationPermissionEvent>(_onCheckLocationPermission);
  }

  Future<void> _onCheckLocationPermission(
      CheckLocationPermissionEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    while (true) {
      bool hasPermission = await _handleLocationPermission();

      if (hasPermission) {
        await _getCurrentPosition();
        emit(SplashSuccess());
        break;
      } else {
        emit(SplashPermissionDenied(
            'Location permission is required to proceed. Please allow it.'));
      }

      // Give a short delay before retrying to avoid continuous dialog opening
      // await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(SplashPermissionDenied(''));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show alert dialog
      bool navigateToSettings = await _showSettingsDialog(mContext);

      if (navigateToSettings) {
        // Navigate to settings
        await openAppSettings();
      } else {
        // Exit the app
        _closeApp();
      }
      return false;
    }

    return true;
  }

  // Helper function to show the AlertDialog
  Future<bool> _showSettingsDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Location permission is permanently denied. You need to allow permissions from settings to proceed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Helper function to close the app
  void _closeApp() {
    SystemNavigator.pop();
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(Constant.MLATITUDE, position.latitude);
      await prefs.setDouble(Constant.MLONGITUDE, position.longitude);
      await prefs.setString(Constant.MRANGE, "50");
    }).catchError((e) {});
  }
}
