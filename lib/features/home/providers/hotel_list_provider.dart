import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/hotel_list_model.dart';
import '../models/hotel_list_params.dart';
import '../services/home_service.dart';

class HotelListProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<List<HotelListModel?>> data;
  bool isLastPage = false;
  bool isLoadingNextPage = true;

  final HomeService _homeService = HomeService();

  getHotelList({HotelListParams? hotelListParams, required BuildContext context}) async {
    isLoading = true;
    data = await _homeService.getHotelList(params: hotelListParams);
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }

  refetchHotelList({HotelListParams? hotelListParams}) async {
    isLoading = true;
    notifyListeners();

    data = await _homeService.getHotelList(params: hotelListParams).then((value) {
      if (value.data.length < 6) {
        isLoadingNextPage = false;
      } else {
        isLoadingNextPage = true;
      }

      return value;
    });
    isLoading = false;
    notifyListeners();
  }

  getHotelListNextPage({HotelListParams? hotelListParams}) async {
    isLoadingNextPage = true;
    data.data.addAll(await _homeService.getHotelList(params: hotelListParams).then((value) {
      if (value.data.length < 6) {
        isLastPage = true;
        isLoadingNextPage = false;
      }

      return value.data.toList();
    }));
    notifyListeners();
  }

  void setIsLastPage() {
    isLastPage = false;
  }
}
