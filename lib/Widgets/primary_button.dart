import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    required this.mSelectcolor,
    required this.mTextColor,
    this.mFontSize = 20,
    this.mHeigth = 45,
    this.radius = 30,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mTextColor;
  final double mFontSize;
  final double mHeigth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onpressed,
        elevation: 5.0,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: mSelectcolor,
            borderRadius: BorderRadius.circular(radius),
          ),
          constraints: BoxConstraints(maxHeight: mHeigth),
          alignment: Alignment.center,
          child: Text(
            mButtonname,
            style: TextStyle(
              color: mTextColor,
              fontFamily: 'PlusJakartaSansSemiBold',
              fontSize: mFontSize,
            ),
          ),
        ));
  }
}
