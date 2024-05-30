import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/responsive.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final String text;
  const IconAndText({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize ?? Responsive.width(context, 3),
        ),
        SizedBox(width: Responsive.width(context, 1)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: Responsive.width(context, 3),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
