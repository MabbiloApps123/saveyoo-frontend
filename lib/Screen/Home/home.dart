import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/HomePageResponse.dart';
import '../../Screen/Home/bloc/home_bloc.dart';
import '../../Screen/Home/bloc/home_event.dart';
import '../../Screen/Home/bloc/home_state.dart';
import '../../Screen/Home/restaurants.dart';
import '../../Screen/Home/supermarketView.dart';
import '../../Widgets/no_internet.dart';
import '../../localization/language/languages.dart';
import '../../utils/pref_manager.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  String _searchQuery = '';
  Data mGetHome = Data();

  late PageController _pageController;
  int activePage = 0;
  Timer? _autoScrollTimer;
  double? Latitude = 0.0;
  double? Longitude = 0.0;
  String? range = "0";

  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

    // Auto-scroll logic
    _autoScrollTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.page != null &&
          _pageController.page!.toInt() < images.length - 1) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut);
      } else {
        _pageController.jumpToPage(0); // Go back to the first page
      }
    });

    BlocProvider.of<HomeBloc>(context).add(SetHome());
    loadPrefs();
  }

  Future<void> loadPrefs() async {
    // mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Latitude = prefs.getDouble(Constant.MLATITUDE);
    Longitude = prefs.getDouble(Constant.MLONGITUDE);
    range = prefs.getString(Constant.MRANGE);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadedState) {}
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetHomeInfoSucessState) {
            mGetHome = state.mHomeData;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        _buildBannerSlider(),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: mGetHome.justForYou!.isNotEmpty,
                          child: Restaurants(
                            mProduct: mGetHome.justForYou!,
                            title: Languages.of(context)!.JustforYou,
                            seeall: Languages.of(context)!.seeall,
                            latitude: Latitude.toString(),
                            longitude: Longitude.toString(),
                            range: range ?? "0",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: mGetHome.lastChanceDeals!.isNotEmpty,
                          child: Restaurants(
                            mProduct: mGetHome.lastChanceDeals!,
                            title: Languages.of(context)!.latechange,
                            seeall: Languages.of(context)!.seeall,
                            latitude: Latitude.toString(),
                            longitude: Longitude.toString(),
                            range: range ?? "0",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: mGetHome.availableNow!.isNotEmpty,
                          child: Restaurants(
                            mProduct: mGetHome.availableNow!,
                            title: Languages.of(context)!.availablenow,
                            seeall: Languages.of(context)!.seeall,
                            latitude: Latitude.toString(),
                            longitude: Longitude.toString(),
                            range: range ?? "0",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: mGetHome.supermarkets!.isNotEmpty,
                          child: SupermarketView(
                            mProduct: mGetHome.supermarkets!,
                            title: Languages.of(context)!.Supermarkets,
                            seeall: Languages.of(context)!.seeall,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: mGetHome.dinnertimeDeals!.isNotEmpty,
                          child: Restaurants(
                            mProduct: mGetHome.dinnertimeDeals!,
                            title: Languages.of(context)!.DinnertimeDeals,
                            seeall: Languages.of(context)!.seeall,
                            latitude: Latitude.toString(),
                            longitude: Longitude.toString(),
                            range: range ?? "0",
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is GetHomeNointernetState) {
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }

  /// Banner Slider with PageView
  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              bool isActive = pagePosition == activePage;
              return _buildSliderImage(images, pagePosition, isActive);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(images.length, activePage),
        ),
      ],
    );
  }

  AnimatedContainer _buildSliderImage(
      List<String> images, int position, bool isActive) {
    double margin = isActive ? 8 : 8;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(images[position]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> indicators(int length, int currentIndex) {
    return List<Widget>.generate(length, (index) {
      return Container(
        margin: const EdgeInsets.all(2),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
