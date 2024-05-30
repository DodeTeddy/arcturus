import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/booking_store_request_model.dart';
import '../services/booking_hotel_service.dart';

class BookingStoreProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<String> data;

  final BookingHotelService _signInService = BookingHotelService();

  bookingStore(BookingStoreRequestModel requestBody, int id, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    data = await _signInService.bookingStore(requestBody, id);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
