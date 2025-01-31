import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final String? mFontFamily;
  final TextDecoration? textDecoration;

  const DefaultText({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.color = Colors.black,
    this.textStyle,
    this.textAlign,
    this.textScaleFactor,
    this.mFontFamily,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.overflow = TextOverflow.ellipsis,
    this.textDecoration,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: textStyle != null
          ? textStyle!.copyWith(
              color: color, fontWeight: fontWeight, fontSize: fontSize)
          : TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: mFontFamily,
              fontSize: fontSize,
              decoration: textDecoration,
            ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
    );
  }
}
