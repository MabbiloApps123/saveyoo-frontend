import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  // List<BottomNavigationBarItem> arrBottomItems = [];
  Color color;
  Color selectedColor;
  bool showSelectedLables;
  bool showUnselectedLables;
  Color backgroundColor;
  int postion = 0;
  // int currentIndex;

  // ignore: sort_constructors_first
  BottomNavigation({
    super.key,
    //  required this.arrBottomItems,
    required this.showSelectedLables,
    required this.showUnselectedLables,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.postion,
    //   required this.currentIndex,
  });

  // final lat = sl<StorageService>().getString(Constant.MLATITUDE);
  // final long = sl<StorageService>().getString(Constant.MLONGITUDE);

  //bool isSelected = index == currentIndex;

  // Helper method to build BottomNavigationBarItem with SVG icons
  BottomNavigationBarItem tabItem({
    required String title,
    required String assetPath,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        color: isSelected ? selectedColor : color,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigatorProvider>(
      builder: (ctx, item, child) {
        final arrBottomItems = [
          tabItem(
            title: Languages.of(context)!.Discover,
            assetPath: 'assets/ic_discover.svg',
            isSelected: item.selectedIndex == 0,
          ),
          tabItem(
            title: Languages.of(context)!.Browse,
            assetPath: 'assets/ic_browser.svg',
            isSelected: item.selectedIndex == 1,
          ),
          tabItem(
            title: Languages.of(context)!.Scan,
            assetPath: 'assets/ic_scan.svg',
            isSelected: item.selectedIndex == 2,
          ),
          tabItem(
            title: Languages.of(context)!.Delivery,
            assetPath: 'assets/ic_delivery.svg',
            isSelected: item.selectedIndex == 3,
          ),
          tabItem(
            title: Languages.of(context)!.Favourites,
            assetPath: 'assets/ic_favorite.svg',
            isSelected: item.selectedIndex == 4,
          ),
        ];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: mBorder, // Color of the top line
                width: 1.0, // Thickness of the top line
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //items: arrBottomItems,
            items: arrBottomItems,
            showSelectedLabels: showSelectedLables,
            showUnselectedLabels: showUnselectedLables,
            backgroundColor: backgroundColor,
            selectedItemColor: selectedColor,
            unselectedItemColor: color,
            currentIndex: item.selectedIndex,
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: "PlusJakartaSansSemiBold",
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: "PlusJakartaSansRegular",
            ),
            onTap: (index) => _onItemTapped(index, context),
          ),
        );
      },
    );
  }

  Future<void> _onItemTapped(int index, BuildContext context) async {
    // ErrorToast(
    //     context: context,
    //     text: "test " + postion.toString() + "-" + index.toString());
    if (index == postion) {
      // If the clicked tab is the same as the current tab, do nothing
      return;
    }
    final bottomProvider =
        Provider.of<BottomNavigatorProvider>(context, listen: false);
    bottomProvider.setSelectedIndex(selectedBottomOption: index);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? lat = prefs.getDouble(Constant.MLATITUDE);
    final double? long = prefs.getDouble(Constant.MLATITUDE);

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 0,
                )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 1,
                )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 2,
                )),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 3,
                )),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 4,
                )),
      );
    }
  }
}

class BottomNavigatorProvider with ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex({int selectedBottomOption = 0}) {
    selectedIndex = selectedBottomOption;
    notifyListeners();
  }
}

/*
* if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 0,
                )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(
            latLng: LatLng(lat ?? 0.0, long ?? 0.0),
            screenpostion: 1,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right to left
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 2,
                )),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 3,
                )),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                  screenpostion: 4,
                )),
      );
    }*/
