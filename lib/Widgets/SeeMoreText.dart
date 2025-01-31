import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/MyColor.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final Color mTextColor;

  const SeeMoreText({
    Key? key,
    required this.text,
    required this.mTextColor,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(
              fontFamily: 'PlusJakartaSansRegular',
              fontSize: 14,
              color: mTextColor),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'See Less' : 'See More',
            style: const TextStyle(
                fontFamily: 'PlusJakartaSansRegular',
                fontSize: 14,
                color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
