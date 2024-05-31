import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/color.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';

class SaldoSectionScreen extends StatelessWidget {
  const SaldoSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(context, 3)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saldo',
                style: TextStyle(
                  fontSize: Responsive.width(context, 4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CurrencyFormat.convertToIdr(123456),
                style: TextStyle(
                  fontSize: Responsive.width(context, 5),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Icon(Iconsax.wallet_1, color: Theme.of(context).colorScheme.primary),
                const Text('Top Up'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
