import 'package:flutter/material.dart';

Widget BuildImage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    child: Image.asset('assets/image1.png', fit: BoxFit.fill),
  );
}
