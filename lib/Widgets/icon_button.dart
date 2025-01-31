import 'package:flutter/material.dart';

class IconwithButton extends StatelessWidget {
  const IconwithButton({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    required this.mSelectcolor,
    required this.mTextColor,
    required this.icon,
    this.mFontSize = 20,
    this.mHeigth = 55,
    this.radius = 30,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mTextColor;
  final double mFontSize;
  final double mHeigth;
  final double radius;
  final String icon;

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
            child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      icon,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          mButtonname,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSansSemiBold',
                            fontSize: mFontSize,
                            color: mTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))

            // Text(
            //   mButtonname,
            //   style: TextStyle(
            //     color: mTextColor,
            //     fontFamily: 'PlusJakartaSansSemiBold',
            //     fontSize: mFontSize,
            //   ),
            // ),
            ));
  }
}
