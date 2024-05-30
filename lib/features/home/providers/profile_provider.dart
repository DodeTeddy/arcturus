import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/profile_model.dart';
import '../services/home_service.dart';

class ProfileProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<ProfileModel?> data;

  final HomeService _homeService = HomeService();

  getProfile(BuildContext context) async {
    isLoading = true;
    data = await _homeService.getProfile();
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;
    notifyListeners();
  }

  refetchGetProfile(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    data = await _homeService.getProfile();
    if (data.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
