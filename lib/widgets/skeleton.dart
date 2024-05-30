import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  final Widget? child;
  const Skeleton({super.key, this.height = 20, this.width = 20, this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: kGreyColor,
      child: child ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
    );
  }
}
