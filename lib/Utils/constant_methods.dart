//import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void showToastMsg({required String msg, required ToastStates toastState}) {
  Toast.show(msg,
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
      backgroundColor: chooseToastColor(state: toastState),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white));
}

Color chooseToastColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.white;
      break;
    case ToastStates.warning:
      color = Colors.white;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

Color darkOrLightColor(Color lightColor, Color darkColor) {
  return lightColor;
}

// checkNetworkStatus() async {
//   // bool isNetworkConnected =
//   //     await FlutterNetworkConnectivity().isNetworkConnectionAvailable();
//
//   // bool isNetworkConnected = false;
//   bool isNetworkConnected = true;
//   // SizerUtil.deviceType == DeviceType.mobile
//   //     ? isNetworkConnected =
//   //         await FlutterNetworkConnectivity().isNetworkConnectionAvailable()
//   //     : isNetworkConnected = true;
//
//   //bool isNetworkConnected = true;
//   if (isNetworkConnected) {
//     print('Mobile network are disabled. Please enable the services');
//   }
//   return isNetworkConnected;
// }

String changeDateFormat(String mdate, String mDateformat) {
  DateTime parseDate = DateFormat(mDateformat).parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd MMM yyyy');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String formatDate(String inputDate) {
  try {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the date and time
    //dd MMM yyyy hh:mm a
    return DateFormat("dd MMM yyyy hh:mm a").format(dateTime.toLocal());
  } catch (e) {
    // Return an error message if parsing fails
    return "Invalid date";
  }
}

String changeTimeFormat(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('HH:mm a');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String changeTimeFormat1(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('hh:mm a');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String changeTimeFormat2(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('HH:mm');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String formatDateToTime(String mdate) {
  // Parse the ISO 8601 date to DateTime object
  DateTime parsedDate = DateTime.parse(mdate);
  // Format the date to the desired time format
  return DateFormat('h.mm a').format(parsedDate.toLocal());
}

bool isMobileNumberValid(String phoneNumber) {
  //String regexPattern = r'^(?:[+0][1-9])?[0-9]{10}$';
  // String regexPattern = r'^(?:[+0][1-9])?[0-9]{10}$';
  String regexPattern = r'[6-9][0-9]{9}$';

  var regExp = RegExp(regexPattern);

  if (phoneNumber.isEmpty) {
    return false;
  } else if (regExp.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}

bool isPasswordValid(String value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
  return false;
}

String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

// String mRazorpayTestKey = 'rzp_test_s2QKOArJgFxKfp';
// String mRazorpayLiveKey = 'rzp_live_YcyEsg4INUtCxt';

String mRazorpayKey = 'rzp_test_s2QKOArJgFxKfp';
String mRazorpayName = 'StartInsights';

//final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month , DateTime.now().day);
final kFirstDay =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
final kLastDay = DateTime(2100, 12, 31);

enum ToastStates { success, error, warning }

enum BookingStatus { upcomming, cancelled, completed }

//const String mAndroidMapKey = 'AIzaSyC3YjVtveQqk7Qr7sG5D1rUAAwsRapEcLE';
const String mAndroidMapKey = 'AIzaSyAdrVn2whpVRM5aclgFvM3_g-W4Xc6yPV0';
//const String miOSMapKey = 'AIzaSyAs-r7zIOV4PUeibHUDcaOGohi7aTvtQjY';
const String miOSMapKey = 'AIzaSyAl86jRqzZt54vmiXaJiEusRTAKkKmbAeo';

//String httpSC = 'http:';
//Image mLoaderGif = Image.asset('assets/ic_loader.gif');
Image mLoaderGif = Image.asset('assets/gifloader.gif');

DateFormat mFirstFormat = DateFormat('dd-MM-yyyy');
DateFormat mDisplayFirstFormat = DateFormat('dd MMM yyyy');
DateFormat mLeaveDateFormat = DateFormat('yyyy-MM-dd');
DateFormat mGetyearFormat = DateFormat('yy');
double mTabelText = 15;
double mLeaveTabelText = 16;
double mTabelTitleText = 18;
double mCaptableTabelText = 14;

const String redirectUrl = 'https://www.youtube.com/callback';
const String clientId = '776rnw4e4izlvg';
const String clientSecret = 'rQEgboUHMLcQi59v';

sharedPreferencesStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
