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

class LoginSuccess extends StatefulWidget {
  String email;
  LoginSuccess({
    super.key,
    required this.email,
  });

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  @override
  late LoginBloc mLoginBloc;
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //BlocProvider.of<LoginBloc>(context).add(SetLogin());
  }

  @override
  void dispose() {
    codeController.dispose();
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              width: 100,
                              height: 100,
                              image: AssetImage(
                                "assets/ic_mailsucess.png",
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(Languages.of(context)!.checkmail,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: mTextColor,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(Languages.of(context)!.sentmailto,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: mGreyDisable,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(widget.email,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: mTextColor,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(Languages.of(context)!.checkbelowmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: mGreyDisable,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: AuthFormField(
                                controller: codeController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText: Languages.of(context)!.code,
                                imageicon: 'assets/ic_maillogin.png',
                                radius: 10,
                                labelText: Languages.of(context)!.code,
                                mBorderView: false,
                                mImageView: false,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PrimaryButton(
                                    mButtonname: Languages.of(context)!.submit,
                                    mFontSize: 15.sp,
                                    onpressed: () {
                                      if (codeController.text.isEmpty) {
                                        ErrorToast(
                                            context: context,
                                            text: Languages.of(context)!
                                                .entercode);
                                      } else {
                                        mLoginBloc.validateOTP(
                                            email: widget.email,
                                            otp: codeController.text);

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           HomeScreen()),
                                        // );
                                      }
                                    },
                                    mSelectcolor: mPrimaryColor,
                                    mTextColor: Colors.white,
                                    mHeigth: 50,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(Languages.of(context)!.notgetcode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: mTextColor,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                mLoginBloc.resendOTP(email: widget.email);
                              },
                              child: Text(Languages.of(context)!.clickhere,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16.sp,
                                    color: mPrimaryColor,
                                    fontFamily: "PlusJakartaSansSemiBold",
                                  )),
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
