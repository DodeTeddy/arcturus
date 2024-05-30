import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/color.dart';

class HotelStar extends StatelessWidget {
  final int star;
  const HotelStar({super.key, required this.star});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          star,
          (index) => const Icon(
            Iconsax.star1,
            color: kYellowColor,
          ),
        ),
      ],
    );
  }
}
