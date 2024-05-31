import 'dart:async';

import 'package:arcturus_mobile_app/features/dashboard/models/dashboard_model.dart';
import 'package:arcturus_mobile_app/features/dashboard/services/dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';

class DashboardProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<DashboardModel?> data;

  final DashboardService _detailHotelService = DashboardService();

  getDashboardData(BuildContext context) async {
    isLoading = true;
    data = await _detailHotelService.getDashboardData();
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;

    notifyListeners();
  }
}
