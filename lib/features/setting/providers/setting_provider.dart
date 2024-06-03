import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/profile_model.dart';
import '../models/update_profile_request_body.dart';
import '../services/setting_service.dart';

class SettingProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<String?> data;

  final SettingService _settingService = SettingService();

  signOut() async {
    isLoading = true;
    notifyListeners();

    data = await _settingService.signOut();
    isLoading = false;
    notifyListeners();
  }

  bool isLoadingUpdate = false;
  late ResponseModel<String?> dataUpdate;

  updatePassword(String password, BuildContext context) async {
    isLoadingUpdate = true;
    notifyListeners();

    dataUpdate = await _settingService.updatePassword(password);
    if (dataUpdate.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingUpdate = false;
    notifyListeners();
  }

  bool isLoadingProfile = false;
  late ResponseModel<ProfileModel?> dataProfile;

  getProfile(BuildContext context) async {
    isLoadingProfile = true;
    dataProfile = await _settingService.getProfile();
    if (dataProfile.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingProfile = false;
    notifyListeners();
  }

  refetchGetProfile(BuildContext context) async {
    isLoadingProfile = true;
    notifyListeners();

    dataProfile = await _settingService.getProfile();
    if (dataProfile.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingProfile = false;
    notifyListeners();
  }

  bool isLoadingUpdatePost = false;
  late ResponseModel<String?> dataUpdatePost;

  updateProfile(UpdateProfileRequestBody requestBody) async {
    isLoadingUpdatePost = true;
    notifyListeners();

    dataUpdatePost = await _settingService.updateProfile(requestBody);
    isLoadingUpdatePost = false;
    notifyListeners();
  }
}
