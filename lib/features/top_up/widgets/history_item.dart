import 'package:flutter/material.dart';

import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';

class HistoryItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const HistoryItem({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Responsive.width(context, 45),
          child: Text(
            label,
            style: TextStyle(
              fontSize: Responsive.width(context, 4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width(context, 2)),
          child: const Text(':'),
        ),
        Expanded(
          child: Text(
            CurrencyFormat.convertToIdr(value),
            style: TextStyle(
              color: color,
              fontSize: Responsive.width(context, 4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
