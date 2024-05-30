import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';

class ButtonSection extends StatelessWidget {
  final String section;
  final List<String> label;
  final Function(int) onLabelTap;
  const ButtonSection({super.key, required this.section, required this.label, required this.onLabelTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: TextStyle(
            fontSize: Responsive.width(context, 4),
          ),
        ),
        ...List.generate(
          label.length,
          (index) {
            return GestureDetector(
              onTap: () => onLabelTap(index),
              child: Container(
                margin: EdgeInsets.only(bottom: Responsive.height(context, 1.5)),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: kGreyColor,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label[index],
                        style: TextStyle(
                          fontSize: Responsive.width(context, 5),
                        ),
                      ),
                    ),
                    const Icon(Iconsax.arrow_right_3),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
