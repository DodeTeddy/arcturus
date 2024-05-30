import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/responsive.dart';

class HotelHeaderList extends StatelessWidget {
  final Function(String) onChangeSort;
  const HotelHeaderList({super.key, required this.onChangeSort});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hotel',
          style: TextStyle(
            fontSize: Responsive.width(context, 5),
          ),
        ),
        PopupMenuButton(
          child: const Icon(Iconsax.sort),
          onSelected: (value) => onChangeSort(value),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem(
              value: "recomended",
              child: Text(
                'Recomended',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const PopupMenuItem(
              value: "low_to_high",
              child: Text(
                'Price (Low To High)',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const PopupMenuItem(
              value: "high_to_low",
              child: Text(
                'Price (High To Low)',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        )
      ],
    );
  }
}
