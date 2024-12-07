import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_bloc.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_event.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_state.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<DeliveryBloc>(context).add(SetDeliveryScreen());
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
      body: BlocConsumer<DeliveryBloc, DeliveryState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is DeliveryLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetDeliveryInfoSucessState) {
            Loading.stop();
            return const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Delivery",
                        style: const TextStyle(
                          fontSize: 28,
                          color: mPrimaryColor,
                          fontFamily: "PlusJakartaSansSemiBold",
                        )),
                  )
                ],
              ),
            );
          } else if (state is GetDeliveryNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
