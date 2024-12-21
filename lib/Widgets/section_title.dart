import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:sizer/sizer.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onPressed,
  });

  final String title;
  final String? action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontFamily: 'PlusJakartaSansSemiBold',
                fontSize: 13.sp,
                color: mGrey)),
        if (action != null)
          TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Text(action!,
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSansMedium',
                          fontSize: 13.sp,
                          color: mPrimaryColor)),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: mPrimaryColor,
                  )
                ],
              )),
      ],
    );
  }
}
