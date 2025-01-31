import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/MyColor.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back press
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: mPrimaryColor,
          title: Text(
            Languages.of(context)!.selectlocation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          centerTitle: false,
        ),
        body: PlacePicker(
          apiKey: Platform.isIOS ? miOSMapKey : mAndroidMapKey,
          hintText: "Search Location ...",
          searchingText: "Please wait ...",
          selectText: "Select Location",
          initialPosition: const LatLng(0.00, 0.00),
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePinPointingSearch: true,
          usePlaceDetailSearch: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          ignoreLocationPermissionErrors: true,
          onPlacePicked: (PickResult result) async {
            // Save the selected place
            selectedPlace = result;

            // Save latitude, longitude, and range to SharedPreferences
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setDouble(
                Constant.MLATITUDE, result.geometry!.location.lat);
            await prefs.setDouble(
                Constant.MLONGITUDE, result.geometry!.location.lng);
            await prefs.setString(Constant.MRANGE, "50");

            // Navigate to HomeScreen with the selected location
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  latLng: LatLng(result.geometry!.location.lat,
                      result.geometry!.location.lng),
                  screenpostion: 0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
