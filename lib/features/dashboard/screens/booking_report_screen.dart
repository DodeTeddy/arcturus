import 'package:arcturus_mobile_app/features/dashboard/models/item_model.dart';
import 'package:arcturus_mobile_app/features/dashboard/providers/dashboard_provider.dart';
import 'package:arcturus_mobile_app/features/dashboard/widgets/booking_report_item.dart';
import 'package:arcturus_mobile_app/routes/route.dart';
import 'package:arcturus_mobile_app/utils/currency_format.dart';
import 'package:arcturus_mobile_app/widgets/custom_elavated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';

class BookingReportScreen extends StatelessWidget {
  const BookingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DashboardProvider>();

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
                    child: !data.isLoading && data.data.data != null
                        ? data.data.data!.getbooking.isNotEmpty
                            ? ListView.builder(
                                itemCount: !data.isLoading && data.data.data != null ? data.data.data!.getbooking.length : 0,
                                itemBuilder: (context, index) {
                                  String status =
                                      !data.isLoading && data.data.data != null ? data.data.data!.getbooking[index].bookingStatus!.toUpperCase() : '';

                                  List<bool> transport = [];

                                  if (!data.isLoading && data.data.data != null) {
                                    for (var j = 0; j < data.data.data!.transport.length; j++) {
                                      if (data.data.data!.getbooking[index].id == int.parse(data.data.data!.transport[j].bookingId!)) {
                                        transport.add(true);
                                      } else {
                                        transport.add(false);
                                      }
                                    }
                                  }

                                  return BookingReportItem(
                                    item: [
                                      ItemModel(
                                        item: 'Hotel Name',
                                        itemValue:
                                            !data.isLoading && data.data.data != null ? data.data.data!.getbooking[index].vendor.vendorName! : '-',
                                      ),
                                      ItemModel(
                                        item: 'Booking Date',
                                        itemValue: !data.isLoading && data.data.data != null
                                            ? data.data.data!.getbooking[index].bookingDate.toString().split(" ")[0]
                                            : '-',
                                      ),
                                      ItemModel(
                                        item: 'CheckIn Date',
                                        itemValue: !data.isLoading && data.data.data != null
                                            ? data.data.data!.getbooking[index].checkinDate.toString().split(" ")[0]
                                            : '-',
                                      ),
                                      ItemModel(
                                        item: 'CheckOut Date',
                                        itemValue: !data.isLoading && data.data.data != null
                                            ? data.data.data!.getbooking[index].checkoutDate.toString().split(" ")[0]
                                            : '-',
                                      ),
                                      ItemModel(
                                        item: 'Nights',
                                        itemValue: !data.isLoading && data.data.data != null ? data.data.data!.getbooking[index].night! : '-',
                                      ),
                                      ItemModel(
                                        item: 'Nights',
                                        itemValue: !data.isLoading && data.data.data != null
                                            ? CurrencyFormat.convertToIdr(
                                                (double.parse(data.data.data!.getbooking[index].price!) +
                                                    double.parse(transport.any((value) => value == true)
                                                        ? data.data.data!.transport
                                                            .firstWhere(
                                                                (value) => int.parse(value.bookingId!) == data.data.data!.getbooking[index].id)
                                                            .totalPrice!
                                                        : '0')),
                                              )
                                            : '-',
                                      ),
                                    ],
                                    children: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: Responsive.height(context, 1)),
                                          padding: EdgeInsets.symmetric(vertical: Responsive.height(context, 1)),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: status == 'PAID' ? kGreenColor : kRedColor),
                                          ),
                                          child: Center(
                                            child: Text(
                                              status,
                                              style: TextStyle(
                                                color: status == 'PAID' ? kGreenColor : kRedColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomElevatedButton(
                                              onPressed: () {},
                                              text: 'Booking Detail',
                                            ),
                                            status == 'PAID'
                                                ? const SizedBox()
                                                : CustomElevatedButton(
                                                    color: kGreenColor,
                                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                                      context,
                                                      paymentScreen,
                                                      (route) => false,
                                                      arguments:
                                                          !data.isLoading && data.data.data != null ? data.data.data!.getbooking[index].id! : null,
                                                    ),
                                                    text: 'Pay',
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'Data Report is Empty!',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: Responsive.width(context, 5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                        : Center(
                            child: Text(
                              'Data Report is Empty!',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Responsive.width(context, 5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
