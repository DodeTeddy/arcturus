import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import '../../home/widgets/date_picker.dart';
import '../models/booking_detail_model.dart';
import '../models/destination_model.dart';
import '../models/transportation_model.dart';
import '../providers/add_transport_provider.dart';
import '../providers/show_booking_info_provider.dart';
import '../widgets/bottom_section.dart';
import '../widgets/middle_section.dart';
import '../widgets/time_picker.dart';
import '../widgets/top_section.dart';

class BookingInfoScreen extends StatefulWidget {
  final BookingDetailModel data;
  const BookingInfoScreen({super.key, required this.data});

  @override
  State<BookingInfoScreen> createState() => _BookingInfoScreenState();
}

class _BookingInfoScreenState extends State<BookingInfoScreen> {
  final _transportFormKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  DestinationModel? destination;
  List<TransportationModel>? transportationList;

  void _bookingSubmission() {
    var showBookingInfo = context.read<ShowBookingInfoProvider>().isShow;
    if (showBookingInfo) {
      if (_transportFormKey.currentState!.validate()) {
        context.read<AddTransportProvider>().addFlight(_controller.text);
        context.read<ShowBookingInfoProvider>().setIsShow();
      }
    }
    if (!showBookingInfo) {
      context.read<ShowBookingInfoProvider>().setIsShow();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var transportation = context.watch<AddTransportProvider>();
    var showBookingInfo = context.watch<ShowBookingInfoProvider>().isShow;

    return Column(
      children: [
        showBookingInfo
            ? Column(
                children: [
                  Text(
                    'Booking Info',
                    style: TextStyle(
                      fontSize: Responsive.width(context, 6),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TopSection(data: widget.data),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Responsive.height(context, 2),
                      bottom: Responsive.height(context, 2),
                    ),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  MiddleSection(data: widget.data),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Responsive.height(context, 2),
                      bottom: Responsive.height(context, 2),
                    ),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  BottomSection(data: widget.data),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Responsive.height(context, 2),
                      bottom: Responsive.height(context, 2),
                    ),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: Responsive.width(context, 6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        CurrencyFormat.convertToIdr(double.parse(widget.data.totalPrice) +
                            double.parse(transportation.transportationdata != null ? transportation.transportationdata!.transportPrice : '0')),
                        style: TextStyle(
                          fontSize: Responsive.width(context, 6),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.height(context, 2)),
                  Text(
                    'Transport',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.width(context, 5),
                    ),
                  ),
                  DropdownButton(
                    hint: const Text('Select Destination'),
                    value: destination,
                    isExpanded: true,
                    items: widget.data.destination
                        .map((value) => DropdownMenuItem<DestinationModel>(
                              value: value,
                              child: Text(value.destination),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      destination = value;
                      transportationList = value!.id == 0
                          ? widget.data.transportation
                          : widget.data.transportation.where((element) => element.transportDestination == value.destination).toList();
                    }),
                  ),
                  SizedBox(height: Responsive.height(context, 2)),
                  DropdownButton(
                    hint: const Text('Select Vehicle'),
                    value: transportation.transportationdata,
                    isExpanded: true,
                    items: transportationList
                        ?.map((value) => DropdownMenuItem<TransportationModel>(value: value, child: Text(value.transportName)))
                        .toList(),
                    onChanged: (value) => destination != null ? context.read<AddTransportProvider>().addTransportation(value!) : null,
                  ),
                  SizedBox(height: Responsive.height(context, 2)),
                  Form(
                    key: _transportFormKey,
                    child: Column(
                      children: [
                        transportation.transportationdata != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text('Time pick up'),
                                        DatePicker(
                                          initialDate: transportation.datepickup,
                                          firstDate: transportation.datepickup,
                                          text: transportation.datepickup.toString().split(" ")[0],
                                          onChanged: (value) {
                                            context.read<AddTransportProvider>().addDatePickUp(value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: Responsive.width(context, 2)),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text('Pick up Date'),
                                        TimePicker(
                                          initialTime: transportation.timepickup,
                                          text: '${transportation.timepickup.hour}:${transportation.timepickup.minute}',
                                          onChanged: (value) {
                                            context.read<AddTransportProvider>().addTimePickUp(value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        transportation.transportationdata != null
                            ? InputTextFormField(
                                label: 'Flight',
                                controller: _controller,
                                validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: Responsive.height(context, 2)),
        CustomElevatedButton(
          onPressed: _bookingSubmission,
          text: showBookingInfo ? 'Booking Submission' : 'Show Booking Info',
        ),
      ],
    );
  }
}
