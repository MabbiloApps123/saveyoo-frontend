import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final String apiKey = Platform.isIOS ? miOSMapKey : miOSMapKey;
  late GoogleMapController mapController;
  LatLng? _selectedLocation;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ErrorToast(context: context, text: 'Location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ErrorToast(context: context, text: 'Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ErrorToast(
          context: context,
          text: 'Location permissions are permanently denied');
      return;
    }

    setState(() => _isLoading = true);
    try {
      Position position = await Geolocator.getCurrentPosition();
      _updateCameraPosition(LatLng(position.latitude, position.longitude));
    } catch (e) {
      ErrorToast(context: context, text: 'Failed to get current location');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateCameraPosition(LatLng position) async {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 14.0));
    _updateSelectedLocation(position);
  }

  Future<void> _updateSelectedLocation(LatLng position) async {
    setState(() => _selectedLocation = position);
    await _reverseGeocode(position);
  }

  Future<void> _reverseGeocode(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        setState(() {
          _selectedAddress = [
            place.street,
            place.locality,
            place.subAdministrativeArea,
            place.postalCode,
            place.country
          ].where((part) => part?.isNotEmpty ?? false).join(', ');

          _searchController.text = _selectedAddress;
        });
      }
    } catch (e) {
      ErrorToast(context: context, text: 'Failed to get address: $e');
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&components=country:in',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = convert.jsonDecode(response.body);
        setState(() => _searchResults = json['predictions']);
      } else {
        ErrorToast(context: context, text: 'Failed to fetch search results');
      }
    } catch (e) {
      ErrorToast(context: context, text: 'Search failed: $e');
    }
  }

  Future<void> _selectPlace(String placeId) async {
    final detailsUrl = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey',
    );

    try {
      final response = await http.get(detailsUrl);
      if (response.statusCode == 200) {
        final json = convert.jsonDecode(response.body);
        final location = json['result']['geometry']['location'];
        final newPosition = LatLng(location['lat'], location['lng']);

        _updateCameraPosition(newPosition);
        setState(() {
          _searchController.clear();
          _searchResults = [];
        });
      }
    } catch (e) {
      // ErrorToast(context: context, text: 'Failed to select place: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchResults = []);
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: _searchPlaces,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  onCameraMove: (position) =>
                      _selectedLocation = position.target,
                  onCameraIdle: () =>
                      _reverseGeocode(_selectedLocation ?? const LatLng(0, 0)),
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation ?? const LatLng(0, 0),
                    zoom: 14.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                const Center(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: FloatingActionButton(
                    backgroundColor: mPrimaryColor,
                    child: const Icon(Icons.my_location, color: Colors.white),
                    onPressed: () {
                      _getCurrentLocation();
                      _reverseGeocode(_selectedLocation!);
                    },
                  ),
                ),
                if (_searchResults.isNotEmpty)
                  Positioned(
                    left: 10,
                    right: 10,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final place = _searchResults[index];
                          return ListTile(
                            title: Text(place['description']),
                            onTap: () => _selectPlace(place['place_id']),
                          );
                        },
                      ),
                    ),
                  ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                Positioned(
                  right: 20,
                  bottom: 30,
                  left: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Select Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    onPressed: () async {
                      if (_selectedLocation != null) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setDouble(
                            Constant.MLATITUDE, _selectedLocation!.latitude);
                        await prefs.setDouble(
                            Constant.MLONGITUDE, _selectedLocation!.longitude);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              latLng: LatLng(_selectedLocation!.latitude,
                                  _selectedLocation!.longitude),
                              screenpostion: 0,
                            ),
                          ),
                        );
                      } else {
                        ErrorToast(
                          context: context,
                          text: 'Please select a location first',
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
