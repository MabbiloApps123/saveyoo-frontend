import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/GetFavouriteResponse.dart';
import 'package:saveyoo/Screen/Favourites/FavPreviewCard.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_bloc.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_event.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_state.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Utils/constant_methods.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  var items = <Datum>[];

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<FavouritesBloc>(context).add(SetFavouritesScreen());
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
      backgroundColor: Colors.white,
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is FavouritesLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetFavouritesInfoSucessState) {
            items = state.mFavData;
            Loading.stop();
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final restaurant = items[index];
                          return SizedBox(
                            child: Column(
                              children: [
                                FavPreviewCard(
                                  restaurant: restaurant!,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is GetFavouritesNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
