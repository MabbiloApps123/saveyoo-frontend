import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/Widgets/auth_form_field.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              width: 80,
                              height: 80,
                              image: AssetImage(
                                "assets/ic_mailsucess.png",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(Languages.of(context)!.checkmail,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(Languages.of(context)!.sentmailto,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(widget.email,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(Languages.of(context)!.checkbelowmail,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: AuthFormField(
                                controller: codeController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!.code,
                                imageicon: 'assets/ic_maillogin.png',
                                radius: 10,
                                labelText: Languages.of(context)!.code,
                                mBorderView: false,
                                mImageView: false,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PrimaryButton(
                                      mButtonname:
                                          Languages.of(context)!.submit,
                                      onpressed: () {
                                        if (codeController.text.isEmpty) {
                                          ErrorToast(
                                              context: context,
                                              text: Languages.of(context)!
                                                  .entercode);
                                        } else {
                                          mLoginBloc.login(
                                              email: "", password: "");

                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           HomeScreen()),
                                          // );
                                        }
                                      },
                                      mSelectcolor: mPrimaryColor,
                                      mTextColor: Colors.white),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(Languages.of(context)!.notgetcode,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(Languages.of(context)!.clickhere,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: mPrimaryColor,
                                  fontFamily: "PlusJakartaSansRegular",
                                )),
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
