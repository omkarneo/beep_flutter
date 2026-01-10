import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int trimLines;

  ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 1,
  });

  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _expanded,
      builder: (context, expanded, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: expanded ? null : trimLines,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyleHelper.mediumStyle(
                color: primaryTextColor,
                // fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                _expanded.value = !expanded;
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  expanded ? 'Read less' : 'Read more',
                  style: TextStyleHelper.mediumStyle(
                    color: primaryTextColor,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
