import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/ProfileResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_bloc.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_event.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_state.dart';
import 'package:saveyoo/Screen/home_screen.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  late ProfileBloc mProfileBloc;
  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(SetProfileScreen());
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mProfileBloc = ProfileBloc(mContext: context);
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    ProfileData mGetProfile = ProfileData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: mPrimaryColor,
            size: 30,
          ),
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            final double? lat = prefs.getDouble(Constant.MLATITUDE);
            final double? long = prefs.getDouble(Constant.MLATITUDE);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        latLng: LatLng(lat ?? 0.0, long ?? 0.0),
                        screenpostion: 0,
                      )),
            );
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is ProfileLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetProfileInfoSucessState) {
            mGetProfile = state.mGetProfile;
            nameController.text = mGetProfile.userName ?? "";
            mobileController.text = mGetProfile.mobileNo ?? "";
            Loading.stop();
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/avathar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: SizedBox(
                          height: 90,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail_rounded,
                                        color: mPrimaryColor,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: 8, left: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Email',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'PlusJakartaSansRegular',
                                                  fontSize: 11.sp,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  mGetProfile.emailId ?? "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PlusJakartaSansSemiBold',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 20, 0),
                                    child: Text(
                                      mGetProfile.emailVerified ?? false
                                          ? 'Email Verified'
                                          : 'Email Not Verified',
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSansSemiBold',
                                        fontSize: 10.sp,
                                        color:
                                            mGetProfile.emailVerified ?? false
                                                ? mPrimaryColor
                                                : Colors.red,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign
                                          .right, // Aligns the text to the right
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: SizedBox(
                        height: 90,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: mPrimaryColor,
                                  size: 28,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            fontFamily:
                                                'PlusJakartaSansRegular',
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: TextField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Enter your name'),
                                              style: TextStyle(
                                                fontFamily:
                                                    'PlusJakartaSansSemiBold',
                                                fontSize: 12.sp,
                                              ),
                                            )

                                            // Text(
                                            //   mGetProfile.userName ?? " - ",
                                            //   style: TextStyle(
                                            //     fontFamily:
                                            //         'PlusJakartaSansSemiBold',
                                            //     fontSize: 12.sp,
                                            //   ),
                                            // ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: SizedBox(
                        height: 90,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: mPrimaryColor,
                                  size: 28,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8, left: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mobile Number',
                                          style: TextStyle(
                                            fontFamily:
                                                'PlusJakartaSansRegular',
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: TextField(
                                            controller: mobileController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter your mobile'),
                                            style: TextStyle(
                                              fontFamily:
                                                  'PlusJakartaSansSemiBold',
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    PrimaryButton(
                      mButtonname: Languages.of(context)!.update,
                      mFontSize: 15.sp,
                      onpressed: () {
                        if (nameController.text.isEmpty) {
                          ErrorToast(
                            context: context,
                            text: Languages.of(context)!.vaildemail,
                          );
                        } else if (mobileController.text.isEmpty) {
                          ErrorToast(
                            context: context,
                            text: Languages.of(context)!.vaildemail,
                          );
                        } else {
                          mProfileBloc.updateprofile(
                              id: mGetProfile.id ?? 1,
                              username: nameController.text,
                              mobileno: mobileController.text,
                              emailverified: mGetProfile.emailVerified ?? false,
                              dob: '2025-01-16T07:33:15.217Z',
                              profileurl: mGetProfile.profileUrl ?? "",
                              devicetoken: mGetProfile.deviceToken ?? "",
                              gender: "Male" ?? "Male",
                              email: mGetProfile.emailId ?? "",
                              password: "");
                        }
                      },
                      mSelectcolor: mPrimaryColor,
                      mTextColor: Colors.white,
                      mHeigth: 50,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetProfileNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }
}
