import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/auth_form_field.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';

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
      body: BlocConsumer<LoginBloc, LoginStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            body: Center(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                      size: 30,
                                      color: Colors.black,
                                      Icons.arrow_back), // Custom back icon
                                  onPressed: () {
                                    Navigator.pop(
                                        context); // Navigates back to the previous screen
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(Languages.of(context)!.started,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "PlusJakartaSansSemiBold",
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(Languages.of(context)!.email,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "PlusJakartaSansMedium",
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AuthFormField(
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        hintText:
                                            Languages.of(context)!.enteremail,
                                        imageicon: 'assets/ic_maillogin.png',
                                        radius: 10,
                                        labelText:
                                            Languages.of(context)!.enteremail,
                                        mBorderView: true,
                                        mImageView: false,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PrimaryButton(
                                    mButtonname:
                                        Languages.of(context)!.Continue,
                                    onpressed: () {
                                      if (emailController.text.isEmpty) {
                                        ErrorToast(
                                            context: context,
                                            text: Languages.of(context)!
                                                .vaildemail);
                                      } else if (!emailController.text
                                          .isValidEmail()) {
                                        ErrorToast(
                                            context: context,
                                            text: Languages.of(context)!
                                                .vaildemail);
                                      } else {
                                        Navigator.pushReplacementNamed(
                                            context, loginsuccessRoute,
                                            arguments: [emailController.text]);
                                        // Navigator.pushReplacementNamed(
                                        //     context, loginsuccessRoute);
                                      }
                                      // else if (passwordController
                                      //     .text.isEmpty) {
                                      //   ErrorToast(
                                      //       context: context,
                                      //       text: Languages.of(context)!
                                      //           .vaildpassword);
                                      // } else {
                                      //   Navigator.pushReplacementNamed(context, dashboardRoute);
                                      // }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => HomeScreen()),
                                      // );
                                    },
                                    mSelectcolor: mPrimaryColor,
                                    mTextColor: Colors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
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
