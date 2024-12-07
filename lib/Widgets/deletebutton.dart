import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    required this.mSelectcolor,
    required this.mTextColor,
    this.mFontSize = 18,
    this.mWidth = 200,
    this.mHeigth = 45,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mTextColor;
  final double mFontSize;
  final double mWidth;
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onpressed,
        textColor: Colors.white,
        hoverColor: Colors.white,
        child: Container(
          width: mWidth,
          height: mHeigth,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(5),
          child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/new_ic_delete.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(mButtonname,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'OpenSauceSansMedium',
                          fontSize: 14,
                          color: Colors.redAccent))
                ],
              )),
        ));
  }
}
