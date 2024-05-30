import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../../detail_hotel/models/room_params.dart';
import '../models/booking_hotel_params.dart';
import '../models/booking_hotel_response_model.dart';
import '../services/booking_hotel_service.dart';

class BookingHotelProvider with ChangeNotifier {
  late BookingHotelParams hotel;
  List<RoomParams> room = [];
  int totalRoom = 0;
  double totalPrice = 0;
  double totalPriceNomarkUp = 0;
  bool isLoading = false;
  late ResponseModel<BookingHotelResponseModel?> data;
  final BookingHotelService _bookingHotelService = BookingHotelService();

  void totalPriceNoMarkUpCalculation(double price, int quantity) {
    totalPriceNomarkUp += (quantity * price);
    notifyListeners();
  }

  void totalPriceCalculation(double price, int quantity) {
    totalPrice += (quantity * price);
    notifyListeners();
  }

  void totalRoomCalculation(int quantity) {
    totalRoom += quantity;
    notifyListeners();
  }

  void totalMinPriceNoMarkUpCalculation(double price, int quantity) {
    totalPriceNomarkUp -= (quantity * price);
    notifyListeners();
  }

  void totalMinPriceCalculation(double price, int quantity) {
    totalPrice -= (quantity * price);
    notifyListeners();
  }

  void totalMinRoomCalculation(int quantity) {
    totalRoom -= quantity;
    notifyListeners();
  }

  void addRoom(RoomParams newRoom) {
    totalRoomCalculation(newRoom.quantity);
    totalPriceCalculation(newRoom.price, newRoom.quantity);
    totalPriceNoMarkUpCalculation(newRoom.priceNoMarkUp, newRoom.quantity);
    room.add(newRoom);

    notifyListeners();
  }

  void removeRoom(RoomParams newRoom) {
    totalMinRoomCalculation(newRoom.quantity);
    totalMinPriceCalculation(newRoom.price, newRoom.quantity);
    totalMinPriceNoMarkUpCalculation(newRoom.priceNoMarkUp, newRoom.quantity);
    room.removeWhere((room) => room.contractId == newRoom.contractId);

    notifyListeners();
  }

  bookingHotel(BookingHotelParams requestBody, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    data = await _bookingHotelService.bookingHotel(requestBody);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }

  void resetBookingHotel() {
    room = [];
    totalRoom = 0;
    totalPrice = 0;
    totalPriceNomarkUp = 0;
    notifyListeners();
  }

  void resetBookingHotelInit() {
    room = [];
    totalRoom = 0;
    totalPrice = 0;
    totalPriceNomarkUp = 0;
  }
}
