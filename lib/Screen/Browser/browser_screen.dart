import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveyoo/Model/HomePageResponse.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_bloc.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_event.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_state.dart';
import 'package:saveyoo/Screen/FilterScreen.dart';
import 'package:saveyoo/Screen/Home/restaurant_preview_card.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/localization/language/languages.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({
    super.key,
  });

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  // 1 -> ListView 2-> Map View
  int mSelectView = 1;
  String selectedFilters = "No filters applied";

  var items = <AvailableNow>[];

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<BrowserBloc>(context).add(SetBrowser());
    setState(() {
      loadPrefs();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort by',
                  style: TextStyle(
                      fontFamily: 'PlusJakartaSansSemiBold',
                      fontSize: 20,
                      color: mGrey)),
              ListTile(
                title: const SortText(menuname: 'Popular'),
                onTap: () {},
              ),
              ListTile(
                title: const SortText(menuname: 'Newest'),
                onTap: () {},
              ),
              ListTile(
                title: const SortText(menuname: 'Customer review'),
                onTap: () {},
              ),
              ListTile(
                title: const SortText(menuname: 'Price: lowest to high'),
                onTap: () {},
              ),
              ListTile(
                title: const SortText(menuname: 'Price: highest to low'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToFilterScreen() async {
    // Navigate to FilterScreen and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FilterScreen(
                onpressed: () {},
              )),
    );

    // Update state with the result from FilterScreen
    if (result != null) {
      setState(() {
        selectedFilters = result; // Update selected filters
        // ErrorToast(context: context, text: selectedFilters);
      });
    }
  }

  void _showFilters(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FilterScreen(
                onpressed: () {},
              )),
    );
  }

  void OnLoadNext() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<BrowserBloc, BrowserState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is BrowserLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetBrowserInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: SearchBar(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(left: 10, right: 10)),
                              controller: _textEditingController,
                              elevation: MaterialStateProperty.all(1.0),
                              side: MaterialStateProperty.all(BorderSide(
                                color: mBorder, // Border color
                                width: 2.0,
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              hintText: 'Search...',
                              shape: MaterialStateProperty.all(
                                  const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                // side: BorderSide(color: Colors.pinkAccent),
                              )),
                              hintStyle: MaterialStateProperty.all(TextStyle(
                                color: mGreyDisable,
                                fontFamily: 'PlusJakartaSansRegular',
                                fontSize: 15,
                              )),
                              textStyle:
                                  MaterialStateProperty.all(const TextStyle(
                                color: mGrey,
                                fontFamily: 'PlusJakartaSansRegular',
                                fontSize: 15,
                              )),
                              onChanged: (String value) {
                                print('value: $value');
                                //filterSearchResults(value);
                              },
                              onTap: () {
                                print('tapped');
                                // The code below only works with SearchAnchor
                                // _searchController.openView();
                              },
                              leading: const Icon(Icons.search,
                                  size: 30, color: kGray),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 50,
                          width: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border:
                                        Border.all(color: mBorder, width: 2.0),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/ic_filter.svg',
                                      width: 24,
                                      height: 24,
                                      //color: isSelected ? selectedColor : color,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // _showFilters(context);
                                  _navigateToFilterScreen();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: mBorder,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: mBorder, width: 0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: (mSelectView == 1)
                                      ? const BoxDecoration(
                                          color: mPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              bottomLeft: Radius.circular(8.0)),
                                        )
                                      : null,
                                  child: Center(
                                    child: Text(Languages.of(context)!.list,
                                        style: TextStyle(
                                            fontFamily: (mSelectView == 1)
                                                ? 'PlusJakartaSansExtraBold'
                                                : 'PlusJakartaSansSemiBold',
                                            fontSize: 18,
                                            color: (mSelectView == 1)
                                                ? Colors.white
                                                : mPrimaryColor)),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    mSelectView = 1;
                                  });
                                }),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: (mSelectView == 2)
                                      ? const BoxDecoration(
                                          color: mPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.0),
                                              bottomRight:
                                                  Radius.circular(8.0)),
                                        )
                                      : null,
                                  child: Center(
                                    child: Text(Languages.of(context)!.map,
                                        style: TextStyle(
                                            fontFamily: (mSelectView == 2)
                                                ? 'PlusJakartaSansExtraBold'
                                                : 'PlusJakartaSansSemiBold',
                                            fontSize: 18,
                                            color: (mSelectView == 2)
                                                ? Colors.white
                                                : mPrimaryColor)),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    mSelectView = 2;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Languages.of(context)!.sortby,
                            style: TextStyle(
                                fontFamily: 'PlusJakartaSansMedium',
                                fontSize: 16,
                                color: mGreyDisable)),
                        TextButton(
                            onPressed: () => _showSortOptions(context),
                            child: Row(
                              children: [
                                Text("Relevance",
                                    style: const TextStyle(
                                        fontFamily: 'PlusJakartaSansExtraBold',
                                        fontSize: 16,
                                        color: mPrimaryColor)),
                                Center(
                                  child: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 30,
                                    color: mPrimaryColor,
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: mSelectView == 1 ? true : false,
                        child: Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final restaurant = items[index];
                              return SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                child: RestaurantPreviewCard(
                                    restaurant: restaurant),
                              );
                            },
                          ),
                        )),
                    Visibility(
                        visible: mSelectView == 2 ? true : false,
                        child: Container(
                          child: Text("Map"),
                        ))
                  ],
                ),
              ),
            );
          } else if (state is GetBrowserNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}

class SortText extends StatelessWidget {
  const SortText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Text(menuname,
        style: const TextStyle(
            fontFamily: 'PlusJakartaSansMedium', fontSize: 16, color: mGrey));
  }
}
