import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/auth_form_field.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginBloc mLoginBloc;
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<LoginBloc>(context).add(SetLogin());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mLoginBloc = LoginBloc(mContext: context);

    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: BlocConsumer<LoginBloc, LoginStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: mBackgroundColor,
                body: Center(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                // Back arrow at the top
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        size: 30,
                                        color: Colors.black,
                                        Icons.arrow_back,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context); // Navigate back
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Languages.of(context)!.started,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "PlusJakartaSansSemiBold",
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 2),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              image: const AssetImage(
                                                  "assets/app_icon.png"),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Languages.of(context)!.email,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansSemiBold",
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              AuthFormField(
                                                controller: emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                hintText: Languages.of(context)!
                                                    .enteremail,
                                                imageicon:
                                                    'assets/ic_maillogin.png',
                                                radius: 10,
                                                labelText:
                                                    Languages.of(context)!
                                                        .enteremail,
                                                mBorderView: true,
                                                mImageView: false,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        PrimaryButton(
                                            mButtonname:
                                                Languages.of(context)!.Continue,
                                            mFontSize: 15.sp,
                                            onpressed: () {
                                              if (emailController
                                                  .text.isEmpty) {
                                                ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .vaildemail,
                                                );
                                              } else if (!emailController.text
                                                  .isValidEmail()) {
                                                ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .vaildemail,
                                                );
                                              } else {
                                                mLoginBloc.login(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text);
                                              }
                                            },
                                            mSelectcolor: mPrimaryColor,
                                            mTextColor: Colors.white,
                                            mHeigth: 50),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class mTextView extends StatelessWidget {
  const mTextView({super.key, required this.mText});

  final String mText;

  @override
  Widget build(BuildContext context) {
    return Text(mText,
        style: const TextStyle(
            fontFamily: 'OpenSansSemiBold', fontSize: 18.0, color: kBlack));
  }
}
