import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';

class BookingReportScreen extends StatelessWidget {
  const BookingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: const [
            BoxShadow(
              color: kGreyColor,
              offset: Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Booking Report',
              style: TextStyle(
                fontSize: Responsive.width(context, 5),
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: kGreyColor),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const Text('Booking Report Data');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
