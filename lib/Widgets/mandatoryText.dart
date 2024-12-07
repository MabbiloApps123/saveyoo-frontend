import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';

class MandatoryText extends StatelessWidget {
  const MandatoryText({
    super.key,
    required this.mText,
    this.mFontsize = 14,
    this.mFontfamily = 'OpenSauceSansExtraBold',
    this.mColor = kBlack,
  });
  final String mText;
  final double mFontsize;
  final String mFontfamily;
  final Color mColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: mText,
          style: TextStyle(
              color: mColor, fontFamily: mFontfamily, fontSize: mFontsize),
          children: [
            TextSpan(
                text: ' *',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: mFontfamily,
                    fontSize: mFontsize))
          ]),
    );
  }
}
