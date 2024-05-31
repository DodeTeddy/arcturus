import 'package:flutter/material.dart';

import '../../../utils/responsive.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Icon icon;
  const InfoItem({super.key, required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                fontSize: Responsive.width(context, 5),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.width(context, 5),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
