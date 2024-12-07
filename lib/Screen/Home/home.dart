import 'dart:async';
import 'dart:convert';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/Home/bloc/home_bloc.dart';
import 'package:saveyoo/Screen/Home/bloc/home_event.dart';
import 'package:saveyoo/Screen/Home/bloc/home_state.dart';
import 'package:saveyoo/Screen/Home/restaurants.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/localization/language/languages.dart';

import '../../Widgets/no_internet.dart';
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

  var items = <Product>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(SetHome());
    setState(() {
      loadPrefs();
    });
    loadUsers();
    //items = loadUsers() as List<ProductsResponse>;
  }

  Future<void> loadPrefs() async {
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  Future<List<ProductsResponse>> loadUsers() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      List<dynamic> usersJson = jsonMap['products'];
      // List<ProductsResponse> users =
      //     usersJson.map((json) => ProductsResponse.fromJson(json)).toList();
      items = ProductsResponse.fromJson(jsonMap).products!;
      print("//////");
      print(items[0].name);
      return [];
    } catch (e) {
      print('Error loading JSON: $e');
      return []; // Return an empty list or handle as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadedState) {}
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            Loading(mLoaderGif).start(context);
            Text("allksgl");
          } else if (state is HomeLoadedState) {
            Loading.stop();
            return SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height, // Fill screen height
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: kGray,
                              ),
                              border: const OutlineInputBorder(),
                              // Border when not focused
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: mBorder, width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              // Border when focused
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: mBorder, width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintStyle: TextStyle(
                                color: mGreyDisable,
                                fontFamily: 'PlusJakartaSansRegular',
                                fontSize: 15,
                              ),
                            ),
                            style: const TextStyle(
                              color: mGrey,
                              fontFamily: 'PlusJakartaSansRegular',
                              fontSize: 15,
                            ),
                            onChanged: (query) {
                              setState(() {
                                _searchQuery = query;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Restaurants(
                          mProduct: items,
                          title: Languages.of(context)!.savelate,
                          seeall: Languages.of(context)!.seeall),
                      const SizedBox(
                        height: 10,
                      ),
                      Restaurants(
                          mProduct: items,
                          title: Languages.of(context)!.SurpriseBags,
                          seeall: Languages.of(context)!.seeall),
                      const SizedBox(
                        height: 10,
                      ),
                      Restaurants(
                          mProduct: items,
                          title: Languages.of(context)!.collectnow,
                          seeall: Languages.of(context)!.seeall),
                    ],
                  ),
                ),
              ),
            ));
          } else if (state is GetHomeNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
