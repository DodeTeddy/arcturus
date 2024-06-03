import 'dart:async';

import 'package:arcturus_mobile_app/features/top_up/models/top_up_model.dart';
import 'package:arcturus_mobile_app/features/top_up/models/top_up_request_model.dart';
import 'package:arcturus_mobile_app/features/top_up/services/top_up_service.dart';
import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';

class TopUpProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<TopUpModel?> data;

  final TopUpService _topUpService = TopUpService();

  getTopUpHistory(BuildContext context) async {
    isLoading = true;
    data = await _topUpService.getTopUpHistory();
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;
    notifyListeners();
  }

  refetchGetTopUpHistory(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    data = await _topUpService.getTopUpHistory();
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;
    notifyListeners();
  }

  bool isLoadingTopUp = false;
  late ResponseModel<String?> dataTopUp;

  topUp(TopUpRequestModel requestBody) async {
    isLoadingTopUp = true;
    notifyListeners();

    dataTopUp = await _topUpService.topUp(requestBody);
    isLoadingTopUp = false;
    notifyListeners();
  }

  resetProvider() {
    isLoading = false;
    isLoadingTopUp = false;
    notifyListeners();
  }
}
