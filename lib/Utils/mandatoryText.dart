import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/FontSizes.dart';
import 'package:saveyoo/Utils/MyColor.dart';

class MandatoryText extends StatelessWidget {
  const MandatoryText({
    super.key,
    required this.mText,
    this.mFontSize = mSizeThree,
  });
  final String mText;
  final double mFontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: mText,
          style: TextStyle(
              color: kBlack,
              fontFamily: 'OpenSauceSansMedium',
              fontSize: mFontSize),
          children: [
            TextSpan(
                text: ' *',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'OpenSauceSansMedium',
                    fontSize: mFontSize))
          ]),
    );
  }
}
