import 'package:arcturus_mobile_app/features/dashboard/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../widgets/info_item.dart';

class InfoSectionScreen extends StatelessWidget {
  const InfoSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DashboardProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(context, 3)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: data.isLoading
          ? Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  fontSize: Responsive.width(context, 6),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : Column(
              children: [
                InfoItem(
                  icon: const Icon(
                    Iconsax.wallet_1,
                    color: kPrimaryColor,
                  ),
                  label: 'Revenue',
                  value: CurrencyFormat.convertToIdr(double.parse(!data.isLoading && data.data.data != null ? data.data.data!.booking! : '0')),
                  color: kPrimaryColor,
                ),
                InfoItem(
                  icon: const Icon(
                    Iconsax.verify,
                    color: kGreenColor,
                  ),
                  label: 'Paid',
                  value: !data.isLoading && data.data.data != null ? data.data.data!.success.toString() : '0',
                  color: kGreenColor,
                ),
                InfoItem(
                  icon: const Icon(
                    Iconsax.danger,
                    color: kRedColor,
                  ),
                  label: 'Unpaid',
                  value: !data.isLoading && data.data.data != null ? data.data.data!.pending.toString() : '0',
                  color: kRedColor,
                ),
                InfoItem(
                  icon: const Icon(
                    Iconsax.home_2,
                    color: Colors.purple,
                  ),
                  label: 'Total Room',
                  value: !data.isLoading && data.data.data != null ? data.data.data!.totalroom.toString() : '0',
                  color: Colors.purple,
                ),
              ],
            ),
    );
  }
}
