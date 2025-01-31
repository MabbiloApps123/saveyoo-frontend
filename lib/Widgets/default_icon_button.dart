import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultIconButton extends StatelessWidget {
  final Widget icon;
  final double radius;
  final Color? background;
  final Color? iconColor;
  final Color? splashColor;
  final VoidCallback onPressed; // voidCallback = void Function()
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final BoxConstraints? constraints;

  const DefaultIconButton({
    super.key,
    required this.onPressed,
    this.text,
    this.background,
    this.radius = 12,
    this.child,
    this.splashColor,
    required this.icon,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(8.0),
    this.iconSize,
    this.iconColor,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: IconButton(
        color: iconColor,
        onPressed: onPressed,
        iconSize: iconSize ?? 24.sp,
        icon: icon,
      ),
    );
  }
}
