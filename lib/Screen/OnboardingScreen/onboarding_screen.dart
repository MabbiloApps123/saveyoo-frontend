import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/OnboardingScreen/bloc/onboarding_bloc.dart';
import 'package:saveyoo/Screen/OnboardingScreen/bloc/onboarding_state.dart';
import 'package:saveyoo/Screen/OnboardingScreen/onboarding_contents.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';
import 'bloc/onboarding_event.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<OnboardingBloc>(context).add(SetOnboarding());
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constant.MONBOARDSCREEN, 1);
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: mPrimaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is OnboardingLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetOnboardingInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) =>
                          setState(() => _currentPage = value),
                      itemCount: contents.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Expanded(
                                // Wrap the Image.asset with Expanded
                                child: Image.asset(
                                  contents[i].image,
                                  // Remove fixed height here, let it be flexible
                                ),
                              ),
                              SizedBox(
                                height: (height >= 840) ? 60 : 30,
                              ),
                              Text(
                                contents[i].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "PlusJakartaSansSemiBold",
                                  fontSize: (width <= 550) ? 30 : 35,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                contents[i].desc,
                                style: TextStyle(
                                  fontFamily: "PlusJakartaSansLight",
                                  fontSize: (width <= 550) ? 17 : 25,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (int index) => _buildDots(
                              index: index,
                            ),
                          ),
                        ),
                        _currentPage + 1 == contents.length
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, landingRoute);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 60, vertical: 15)
                                        : EdgeInsets.symmetric(
                                            horizontal: width * 0.2,
                                            vertical: 15),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17),
                                  ),
                                  child: const Text("START",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansSemiBold',
                                          fontSize: 16.0,
                                          color: Colors.white)),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // _controller.jumpToPage(2);
                                        Navigator.pushReplacementNamed(
                                            context, landingRoute);
                                      },
                                      style: TextButton.styleFrom(
                                        elevation: 0,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: (width <= 550) ? 13 : 17,
                                        ),
                                      ),
                                      child: const Text(
                                        "SKIP",
                                        style: TextStyle(
                                            fontFamily:
                                                'PlusJakartaSansSemiBold',
                                            fontSize: 16.0,
                                            color: mPrimaryColor),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        elevation: 0,
                                        padding: (width <= 550)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 15),
                                        textStyle: TextStyle(
                                            fontSize: (width <= 550) ? 13 : 17),
                                      ),
                                      child: const Text("NEXT",
                                          style: TextStyle(
                                              fontFamily:
                                                  'PlusJakartaSansSemiBold',
                                              fontSize: 16.0,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetOnboardingNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
