import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saveyoo/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:saveyoo/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Widgets/no_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localization/language/languages.dart';
import '../../utils/constant.dart';
import '../../utils/pref_manager.dart';

//state.mDashboard.activites![0].description!,

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageService storageService = StorageService();

  String mUserName = "";
  String mUserEmail = "";
  String mUserImage = "";
  DashboardBloc? mDashboardBloc;
  bool hasInterNetConnection = false;
  Position? _currentPosition;
  String hasPunchIn = "OUT";
  String mSelectDB = "";
  String mSelectDBHint = "";
  String mSelectRoute = "";
  String mSelectRouteHint = "";

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mUserName = (prefs.getString(Constant.MUSERNAME) ?? '');
      mUserEmail = (prefs.getString(Constant.MUSEREMAIL) ?? '');
      mUserImage = (prefs.getString(Constant.MUSEREIMAGE) ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // mDashboardBloc = DashboardBloc(mContext: context);
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        //OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
                // if (hasPunchIn == "IN") {
                //
                // } else {
                //   ErrorToast(
                //       context: context,
                //       text: Languages.of(context)!.punchinerror);
                // }
              },
              icon: Image.asset(
                'assets/ic_menu.png',
                fit: BoxFit.contain,
                height: 30,
              ),
            ),
            title: Image.asset(
              'assets/app_icon.png',
              fit: BoxFit.contain,
              height: 40,
            ), //title of app
            backgroundColor: Colors.white, //elevation value of appbar

            actions: [
              //actions widget in appbar

              IconButton(
                icon: CircleAvatar(
                  backgroundImage:
                      const ExactAssetImage('assets/avathar.png', scale: 30),
                  child: ClipOval(
                    child: (mUserImage.isNotEmpty)
                        ? Image.network(mUserImage,
                            width: 30, height: 30, fit: BoxFit.fill)
                        : Image.asset('assets/avathar.png',
                            width: 30, height: 30, fit: BoxFit.fill),
                  ), //Text
                ),
                onPressed: () {},
              ),
              //more widgets to place here
            ],
          ),
          drawer: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.red),
                  accountName: Text(
                    "User Name",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "Username@gmail.com",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        const ExactAssetImage('assets/avathar.png', scale: 100),
                    child: ClipOval(
                      child: (mUserImage.isNotEmpty)
                          ? Image.network(mUserImage,
                              width: 100, height: 100, fit: BoxFit.fill)
                          : Image.asset('assets/avathar.png',
                              width: 100, height: 100, fit: BoxFit.fill),
                    ),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const sidemenuImage(menuicon: 'assets/app_icon.png'),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: SidemenuText(menuname: Languages.of(context)!.appName),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(Languages.of(context)!.appName),
                        content: Text(Languages.of(context)!.appName),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Text(Languages.of(context)!.appName),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              storageService.deleteAllItem();

                              // ignore: use_build_context_synchronously
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Text(Languages.of(context)!.appName),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          body: BlocConsumer<DashboardBloc, DashboardState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DashboardLoadingState) {
                Loading(mLoaderGif).start(context);
                //DefaultLoadingIndicator();
              } else if (state is GetDashboardInfoSuccessState) {
                Loading.stop();
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("PPP")],
                      ),
                    ),
                  ),
                );
              } else if (state is GetDashboardInfoFailState) {
                Loading.stop();
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("PPP"),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is GetDashboardNointernetState) {
                Loading.stop();
                return SafeArea(child: NoInternet());
              }
              return Container();
            },
          )),
    );
  }
}

class dialogText extends StatelessWidget {
  const dialogText(
      {super.key,
      required this.mText,
      required this.mTextColor,
      required this.mFontSize,
      required this.mFontFamily,
      required this.malignment,
      required this.mtextalign});

  final AlignmentGeometry malignment;
  final TextAlign mtextalign;
  final String mText;
  final Color mTextColor;
  final double mFontSize;
  final String mFontFamily;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: malignment,
      child: Text(
        mText,
        textAlign: mtextalign,
        style: TextStyle(
          color: mTextColor,
          fontFamily: mFontFamily,
          fontSize: mFontSize,
        ),
      ),
    );
  }
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      menuicon,
      height: 25,
    );
  }
}

class SidemenuText extends StatelessWidget {
  const SidemenuText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Text(menuname,
        style: const TextStyle(
          fontFamily: 'TimesNormal',
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ));
  }
}
