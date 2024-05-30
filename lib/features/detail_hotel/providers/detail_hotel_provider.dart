import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/detail_hotel_model.dart';
import '../models/detail_hotel_params.dart';
import '../services/detail_hotel_service.dart';

class DetailHotelProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<DetailHotelModel?> data;

  final DetailHotelService _detailHotelService = DetailHotelService();

  getDetailHotel({DetailHotelParams? params, required int id, required BuildContext context}) async {
    isLoading = true;
    data = await _detailHotelService.getDetailHotel(id: id, params: params);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }

  refetchDetailHotel({DetailHotelParams? params, required int id, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();

    data = await _detailHotelService.getDetailHotel(id: id, params: params);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }

  setQuantity(int indexRoomAvailable, int indexRoom, int quantity) {
    data.data!.availableRoom[indexRoomAvailable].room[indexRoom].quantity = quantity;
    notifyListeners();
  }
}
