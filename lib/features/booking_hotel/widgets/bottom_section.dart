import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../models/booking_detail_model.dart';
import '../providers/add_transport_provider.dart';

class BottomSection extends StatelessWidget {
  final BookingDetailModel data;
  const BottomSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var transportation = context.watch<AddTransportProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Room'),
        ...List.generate(data.room.length, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${data.room[index].roomTotal} x ${data.room[index].roomName}',
                style: TextStyle(
                  fontSize: Responsive.width(context, 4.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CurrencyFormat.convertToIdr(double.parse(data.room[index].roomPrice)),
                style: TextStyle(
                  fontSize: Responsive.width(context, 4.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }),
        SizedBox(height: Responsive.height(context, 3)),
        const Text('Transport'),
        transportation.transportationdata != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transportation.transportationdata != null ? transportation.transportationdata!.transportName : '',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 4.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(
                        double.parse(transportation.transportationdata != null ? transportation.transportationdata!.transportPrice : '0')),
                    style: TextStyle(
                      fontSize: Responsive.width(context, 4.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
