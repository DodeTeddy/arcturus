import 'package:flutter/material.dart';

import '../../../utils/responsive.dart';
import '../models/booking_detail_model.dart';

class MiddleSection extends StatelessWidget {
  final BookingDetailModel data;
  const MiddleSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: Responsive.width(context, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check In',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(data.checkIn.split(' ')[0]),
                ],
              ),
            ),
            SizedBox(
              width: Responsive.width(context, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check Out',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(data.checkOut.split(' ')[0]),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: Responsive.height(context, 2)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: Responsive.width(context, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Person',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(data.person),
                ],
              ),
            ),
            SizedBox(
              width: Responsive.width(context, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Night',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(data.night),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
