import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../models/sign_in_request_body.dart';
import '../models/sign_in_response_model.dart';
import '../services/sign_in_service.dart';

class SignInProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<SignInResponseModel?> data;

  final SignInService _signInService = SignInService();

  signIn(SignInRequestBody requestBody) async {
    isLoading = true;
    notifyListeners();

    data = await _signInService.signIn(requestBody);
    isLoading = false;
    notifyListeners();
  }

  bool isLoadingReset = false;
  late ResponseModel<String?> dataReset;

  resetPasword(String email) async {
    isLoadingReset = true;
    notifyListeners();

    dataReset = await _signInService.forgotPassword(email);
    isLoadingReset = false;
    notifyListeners();
  }
}
