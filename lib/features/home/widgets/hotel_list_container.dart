import 'package:flutter/material.dart';

import '../../../utils/responsive.dart';

class HotelListContainer extends StatelessWidget {
  final List<Widget> children;
  const HotelListContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: Responsive.height(context, 0.5),
          left: Responsive.width(context, 2.5),
          right: Responsive.width(context, 2.5),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
