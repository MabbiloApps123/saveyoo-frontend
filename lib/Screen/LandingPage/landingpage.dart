import 'dart:async';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/icon_button.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';
import 'bloc/landingpage_bloc.dart';
import 'bloc/landingpage_event.dart';
import 'bloc/landingpage_state.dart';

class Landingpage extends StatefulWidget {
  Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LandingpageBloc>(context).add(SetLandingpage());
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LandingpageBloc, LandingpageState>(
        listener: (context, state) {
          if (state is LandingpageLoadedState) {}
        },
        builder: (context, state) {
          if (state is LandingpageLoadingState) {
            Loading(mLoaderGif).start(context);
            Text("allksgl");
          } else if (state is LandingpageLoadedState) {
            Loading.stop();
            return SafeArea(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconwithButton(
                        mButtonname: Languages.of(context)!.maillogin,
                        onpressed: () {
                          Navigator.pushReplacementNamed(context, loginRoute);
                        },
                        icon: 'assets/ic_mail.png',
                        mSelectcolor: mPrimaryColor,
                        mTextColor: Colors.white,
                        mFontSize: 14.sp),
                    const SizedBox(
                      height: 30,
                    ),
                    IconwithButton(
                        mButtonname: Languages.of(context)!.gmaillogin,
                        onpressed: () {},
                        icon: 'assets/ic_google.png',
                        mSelectcolor: mPrimaryColor,
                        mTextColor: Colors.white,
                        mFontSize: 14.sp),
                    const SizedBox(
                      height: 30,
                    ),
                    IconwithButton(
                        mButtonname: Languages.of(context)!.applelogin,
                        onpressed: () {},
                        icon: 'assets/ic_apple.png',
                        mSelectcolor: mPrimaryColor,
                        mTextColor: Colors.white,
                        mFontSize: 14.sp),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ), // Replace with your child widget
            ));
          } else if (state is GetLandingpageNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
