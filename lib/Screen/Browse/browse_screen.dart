import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_bloc.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_event.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_state.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<BrowseBloc>(context).add(SetBrowseScreen());
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      body: BlocConsumer<BrowseBloc, BrowseState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is BrowseLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetBrowseInfoSucessState) {
            Loading.stop();
            return const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Browse",
                        style: const TextStyle(
                          fontSize: 28,
                          color: mPrimaryColor,
                          fontFamily: "PlusJakartaSansSemiBold",
                        )),
                  )
                ],
              ),
            );
          } else if (state is GetBrowseNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
