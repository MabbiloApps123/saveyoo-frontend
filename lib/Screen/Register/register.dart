import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Register/bloc/register_bloc.dart';
import 'package:saveyoo/Screen/Register/bloc/register_state.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Widgets/auth_form_field.dart';
import 'package:saveyoo/Widgets/primary_button.dart';
import 'package:saveyoo/localization/language/languages.dart';

import '../../Utils/MyColor.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late RegisterBloc mRegisterBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mRegisterBloc = RegisterBloc(mContext: context);

    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterStatus>(
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
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context)!.mRegister,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: "PlusJakartaSansSemiBold",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
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
                                      Text(Languages.of(context)!.mName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "PlusJakartaSansMedium",
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AuthFormField(
                                        controller: nameController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        hintText:
                                            Languages.of(context)!.menterName,
                                        imageicon: 'assets/ic_maillogin.png',
                                        radius: 10,
                                        labelText:
                                            Languages.of(context)!.menterName,
                                        mBorderView: true,
                                        mImageView: false,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(Languages.of(context)!.password,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "PlusJakartaSansMedium",
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AuthFormField(
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          hintText: Languages.of(context)!
                                              .enterpassword,
                                          controller: passwordController,
                                          imageicon: 'assets/ic_locklogin.png',
                                          radius: 10,
                                          labelText: Languages.of(context)!
                                              .enterpassword,
                                          obscureText: true,
                                          maxLines: 1),
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
                                        Languages.of(context)!.mRegister,
                                    onpressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => HomeScreen()),
                                      // );
                                      // if (nameController.text.isEmpty) {
                                      //   ErrorToast(
                                      //       context: context,
                                      //       text: Languages.of(context)!
                                      //           .menterName);
                                      // } else if (emailController.text.isEmpty) {
                                      //   ErrorToast(
                                      //       context: context,
                                      //       text: Languages.of(context)!
                                      //           .vaildemail);
                                      // } else if (!emailController.text
                                      //     .isValidEmail()) {
                                      //   ErrorToast(
                                      //       context: context,
                                      //       text: Languages.of(context)!
                                      //           .vaildemail);
                                      // } else if (passwordController
                                      //     .text.isEmpty) {
                                      //   ErrorToast(
                                      //       context: context,
                                      //       text: Languages.of(context)!
                                      //           .vaildpassword);
                                      // } else {}
                                    },
                                    mSelectcolor: mPrimaryColor,
                                    mTextColor: Colors.white),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              Languages.of(context)!
                                                  .mAlreadyuser,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'PlusJakartaSansRegular',
                                                  color: mGreyEigth)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            child: Text(
                                                Languages.of(context)!.login,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'PlusJakartaSansSemiBold',
                                                    color: kBlack)),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, loginRoute);
                                            },
                                          ),
                                        ]),
                                  ),
                                )
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
