import 'package:flutter/material.dart';
import 'package:saveyoo/Widgets/primary_button.dart';

import '../Localization/language/languages.dart';
import '../Utils/MyColor.dart';

class NoInternet extends StatelessWidget {
  NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Align(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage(
              "assets/nointernet_connection.png",
            ),
          ),
        ),
        Text(
          Languages.of(context)!.appName,
          style: const TextStyle(
              fontFamily: 'OpenSansBold', fontSize: 22, color: kBlack),
          // TextStyle
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          Languages.of(context)!.appName,
          style: const TextStyle(
              fontFamily: 'OpenSansBold', fontSize: 18, color: kBlack),
          // TextStyle
        ),
        const SizedBox(
          height: 20,
        ),
        PrimaryButton(
          mButtonname: Languages.of(context)!.appName,
          onpressed: () {},
          mSelectcolor: kBlack,
          mTextColor: Colors.black,
        ),
      ]),
    );
  }
}
