import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saveyoo/Utils/utils.dart';

class LocationPermissionPage extends StatelessWidget {
  Future<void> _checkLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      // Navigate to the next page if permission is already granted
      ErrorToast(
          context: context,
          text: 'Navigate to the next page if permission is already granted');
    } else if (status.isDenied || status.isRestricted) {
      // Request permission
      PermissionStatus newStatus = await Permission.location.request();

      if (newStatus.isGranted) {
        // Navigate to the next page if permission is granted
        ErrorToast(
            context: context,
            text: 'Navigate to the next page if permission is granted');
      } else {
        ErrorToast(
            context: context,
            text: 'Location permission is required to proceed.');
        // Show a message if permission is denied
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       'Location permission is required to proceed.',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     backgroundColor: Colors.red,
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Permission'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _checkLocationPermission(context),
          child: Text('Enable Location & Continue'),
        ),
      ),
    );
  }
}
