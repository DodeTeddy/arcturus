import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../models/enum_condition.dart';
import '../../../routes/route.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import '../../sign_up/widgets/dropdown_country.dart';
import '../models/booking_detail_model.dart';
import '../models/booking_store_request_model.dart';
import '../providers/add_transport_provider.dart';
import '../providers/booking_store_provider.dart';

class BookingSubmissionScreen extends StatefulWidget {
  final int bookingId;
  final BookingDetailModel data;
  const BookingSubmissionScreen({super.key, required this.data, required this.bookingId});

  @override
  State<BookingSubmissionScreen> createState() => _BookingSubmissionScreenState();
}

class _BookingSubmissionScreenState extends State<BookingSubmissionScreen> {
  final _bookingFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressOneController = TextEditingController();
  final TextEditingController _addressTwoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _requirementController = TextEditingController();
  String _countrySelected = '';
  bool termsCondition = false;
  bool notCheckTerm = false;

  void _checkBookingStoreProgress() {
    var response = context.read<BookingStoreProvider>().data;

    if (response.statusCode == 200) {
      snackBar(
        context: context,
        condition: Condition.success,
        message: 'Booking success',
      );

      Timer(const Duration(milliseconds: 3000), () {
        Navigator.pushNamedAndRemoveUntil(context, paymentScreen, (route) => false, arguments: widget.bookingId);
      });
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Something wrong...',
      );
    }
  }

  void _bookingSubmit() async {
    if (_bookingFormKey.currentState!.validate()) {
      var bookingStore = context.read<BookingStoreProvider>().bookingStore;
      var transport = context.read<AddTransportProvider>();

      await bookingStore(
        BookingStoreRequestModel(
          firstname: _firstNameController.text,
          lastname: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          addressLine1: _addressOneController.text,
          addressLine2: _addressTwoController.text,
          zipcode: _codeController.text,
          city: _cityController.text,
          country: _countrySelected,
          state: _stateController.text,
          specialRequest: _requirementController.text,
          idtransport: transport.transportationdata != null ? transport.transportationdata!.id : 1,
          timepickup: transport.transportationdata != null ? '${transport.timepickup.hour}:${transport.timepickup.minute}' : '',
          flight: transport.transportationdata != null ? transport.flight! : '',
          datepickup: transport.transportationdata != null ? transport.datepickup.toString().split(' ')[0] : '',
        ),
        widget.bookingId,
        context,
      );

      _checkBookingStoreProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Booking Submission',
          style: TextStyle(
            fontSize: Responsive.width(context, 6),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Form(
          key: _bookingFormKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InputTextFormField(
                      label: 'First Name',
                      controller: _firstNameController,
                      validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
                    ),
                    InputTextFormField(
                        label: 'Email',
                        controller: _emailController,
                        validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null),
                    InputTextFormField(
                      label: 'Address Line 1',
                      controller: _addressOneController,
                    ),
                    InputTextFormField(
                      label: 'City',
                      controller: _cityController,
                    ),
                    InputTextFormField(
                      label: 'ZIP code/Postal code',
                      controller: _codeController,
                    ),
                  ],
                ),
              ),
              SizedBox(width: Responsive.width(context, 2)),
              Expanded(
                child: Column(
                  children: [
                    InputTextFormField(
                        label: 'Last Name',
                        controller: _lastNameController,
                        validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null),
                    InputTextFormField(
                        keyboardType: TextInputType.phone,
                        label: 'Phone',
                        controller: _phoneController,
                        validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null),
                    InputTextFormField(
                      label: 'Adress Line 2',
                      controller: _addressTwoController,
                    ),
                    InputTextFormField(
                      label: 'State/Province/Region',
                      controller: _stateController,
                    ),
                    DropdownCountry(
                      onChanged: (value) => _countrySelected = value!.label,
                      validator: (value) => value == null || value.value.toString().isEmpty ? 'Cannot be empty' : null,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        InputTextFormField(
          label: 'Special Requirements',
          controller: _requirementController,
        ),
        Row(
          children: [
            Checkbox(
              side: const BorderSide(
                color: kGreyColor,
                strokeAlign: 0,
              ),
              value: termsCondition,
              onChanged: (value) => setState(() {
                termsCondition = value!;
                if (value) {
                  notCheckTerm = false;
                }
              }),
            ),
            Expanded(
              child: Text(
                'I have read and accept the terms and conditions',
                style: TextStyle(color: notCheckTerm ? kRedColor : kGreyColor),
              ),
            ),
          ],
        ),
        CustomElevatedButton(
          isLoading: context.watch<BookingStoreProvider>().isLoading,
          onPressed: termsCondition
              ? _bookingSubmit
              : () => setState(() {
                    notCheckTerm = true;
                  }),
          text: 'Submit',
        ),
      ],
    );
  }
}
