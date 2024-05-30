import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class CustomLayout extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const CustomLayout({
    super.key,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Responsive.height(context, 5),
            horizontal: Responsive.width(context, 5),
          ),
      child: child,
    );
  }
}
