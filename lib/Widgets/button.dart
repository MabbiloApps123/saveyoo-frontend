import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    required this.mSelectcolor,
    required this.mTextColor,
    this.mHovercolor = Colors.white,
    this.mFontSize = 18,
    this.mWidth = 200,
    this.mHeigth = 45,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mTextColor;
  final Color mHovercolor;
  final double mFontSize;
  final double mWidth;
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onpressed,
        textColor: Colors.white,
        hoverColor: mHovercolor,
        child: Container(
          width: mWidth,
          height: mHeigth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kGray, Colors.red],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(5),
          child: Align(
              alignment: Alignment.center,
              child: Text(mButtonname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'OpenSauceSansMedium',
                      fontSize: 14,
                      color: mTextColor))),
        ));
  }
}
