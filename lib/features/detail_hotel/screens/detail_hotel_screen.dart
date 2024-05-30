import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../models/enum_condition.dart';
import '../../../models/enum_response_message.dart';
import '../../../routes/route.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../booking_hotel/models/booking_hotel_params.dart';
import '../../booking_hotel/providers/booking_hotel_provider.dart';
import '../../home/providers/filter_section_provider.dart';
import '../models/detail_hotel_arguments.dart';
import '../models/detail_hotel_params.dart';
import '../providers/detail_hotel_provider.dart';
import '../widgets/bottom_sheet_body.dart';
import 'detail_hotel_error_screen.dart';
import 'filter_detail_hotel_screen.dart';
import 'heading_section_screen.dart';
import 'list_room_hotel_screen.dart';

class DetailHotelScreen extends StatefulWidget {
  final DetailHotelArguments arguments;
  const DetailHotelScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<DetailHotelScreen> createState() => _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  void viewRates(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetBody(indexRoomAvailable: index);
      },
    );
  }

  void checkBookProses() {
    var response = context.read<BookingHotelProvider>().data;

    if (response.statusCode == 200) {
      snackBar(
        context: context,
        condition: Condition.success,
        message: 'Booking success...',
      );

      Timer(const Duration(milliseconds: 2000), () {
        Navigator.pushNamed(context, bookingHotelScreen, arguments: response.data!.bookingId);
      });
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Something wrong...',
      );
    }
  }

  void bookNow() async {
    var filter = context.read<FilterSectionProvider>();
    var bookNow = context.read<BookingHotelProvider>().bookingHotel;

    await bookNow(
      BookingHotelParams(
        checkIn: filter.checkIn.toString().split(' ')[0],
        checkOut: filter.checkOut.toString().split(' ')[0],
        person: filter.person,
        room: context.read<BookingHotelProvider>().room,
        totalPrice: context.read<BookingHotelProvider>().totalPrice.toString(),
        vendorId: context.read<DetailHotelProvider>().data.data!.vendorId.toString(),
        totalPriceNomarkUp: context.read<BookingHotelProvider>().totalPriceNomarkUp.toString(),
      ),
      context,
    );

    checkBookProses();
  }

  @override
  void initState() {
    context.read<BookingHotelProvider>().resetBookingHotelInit();
    var params = context.read<FilterSectionProvider>();
    context.read<DetailHotelProvider>().getDetailHotel(
          id: widget.arguments.idContractrate,
          params: DetailHotelParams(
            person: params.person.toString(),
            checkIn: params.checkIn.toString().split(' ')[0],
            checkOut: params.checkOut.toString().split(' ')[0],
            country: '',
            sort: '',
          ),
          context: context,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DetailHotelProvider>();
    var filter = context.watch<FilterSectionProvider>();
    var room = context.watch<BookingHotelProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              (!data.isLoading && data.data.message == ResponseMessage.error) || (!data.isLoading && data.data.message == ResponseMessage.errorCatch)
                  ? DetailHotelErrorScreen(
                      id: widget.arguments.idContractrate,
                    )
                  : Stack(
                      children: [
                        const HeadingSectionScreen(),
                        Column(
                          children: [
                            SizedBox(height: Responsive.height(context, 18)),
                            FilterDetailHotelScreen(
                              id: widget.arguments.idContractrate,
                            ),
                            ListRoomHotelScreen(viewRates: (value) => viewRates(value)),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: Responsive.width(context, 3),
                                vertical: Responsive.height(context, 2),
                              ),
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Room: ${room.totalRoom}'),
                                      Text(
                                        'Total Price: ${CurrencyFormat.convertToIdr(room.totalPrice)}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Night: ${(filter.checkOut.day - filter.checkIn.day)}'),
                                      context.watch<BookingHotelProvider>().room.isNotEmpty
                                          ? CustomElevatedButton(
                                              isLoading: context.watch<BookingHotelProvider>().isLoading,
                                              onPressed: bookNow,
                                              text: 'Book Now',
                                            )
                                          : const SizedBox()
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
