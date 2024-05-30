import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/booking_detail_model.dart';
import '../services/booking_hotel_service.dart';

class BookingDetailProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<BookingDetailModel?> data;

  final BookingHotelService _bookingHotelService = BookingHotelService();

  getBookingDetail(int bookingId, BuildContext context) async {
    isLoading = true;
    data = await _bookingHotelService.getDetailBooking(bookingId);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }
}
