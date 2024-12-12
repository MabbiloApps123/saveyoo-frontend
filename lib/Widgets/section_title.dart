import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontFamily: 'PlusJakartaSansSemiBold',
                  fontSize: 16,
                  color: mGrey)),
          if (action != null)
            TextButton(
                onPressed: onPressed,
                child: Row(
                  children: [
                    Text(action!,
                        style: const TextStyle(
                            fontFamily: 'PlusJakartaSansMedium',
                            fontSize: 16,
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
      ),
    );
  }
}
