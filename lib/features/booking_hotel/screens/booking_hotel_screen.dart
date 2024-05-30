import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';
import '../providers/add_transport_provider.dart';
import '../providers/booking_detail_hotel_provider.dart';
import '../providers/show_booking_info_provider.dart';
import 'booking_info_screen.dart';
import 'booking_submission_screen.dart';

class BookingHotelScreen extends StatefulWidget {
  final int bookingId;
  const BookingHotelScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<BookingHotelScreen> createState() => _BookingHotelScreenState();
}

class _BookingHotelScreenState extends State<BookingHotelScreen> {
  @override
  void initState() {
    context.read<BookingDetailProvider>().getBookingDetail(widget.bookingId, context);
    context.read<AddTransportProvider>().reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<BookingDetailProvider>();
    var showBookingInfo = context.watch<ShowBookingInfoProvider>().isShow;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Booking',
          style: TextStyle(fontSize: Responsive.width(context, 5)),
        ),
        iconTheme: const IconThemeData(
          color: kWhiteColor,
        ),
      ),
      body: data.isLoading
          ? Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      BookingInfoScreen(data: data.data.data!),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Responsive.height(context, 5),
                          bottom: Responsive.height(context, 5),
                        ),
                        child: Divider(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      showBookingInfo ? const SizedBox() : BookingSubmissionScreen(data: data.data.data!, bookingId: widget.bookingId),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
