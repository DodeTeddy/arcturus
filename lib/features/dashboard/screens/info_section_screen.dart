import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/color.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../widgets/info_item.dart';

class InfoSectionScreen extends StatelessWidget {
  const InfoSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(context, 3)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          InfoItem(
            icon: const Icon(
              Iconsax.wallet_1,
              color: kPrimaryColor,
            ),
            label: 'Total Revenue',
            value: CurrencyFormat.convertToIdr(123456),
            color: kPrimaryColor,
          ),
          const InfoItem(
            icon: Icon(
              Iconsax.verify,
              color: kGreenColor,
            ),
            label: 'Booking Paid',
            value: '8',
            color: kGreenColor,
          ),
          const InfoItem(
            icon: Icon(
              Iconsax.danger,
              color: kRedColor,
            ),
            label: 'Booking Unpaid',
            value: '15',
            color: kRedColor,
          ),
          const InfoItem(
            icon: Icon(
              Iconsax.home_2,
              color: Colors.purple,
            ),
            label: 'Total Room Night',
            value: '105',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
