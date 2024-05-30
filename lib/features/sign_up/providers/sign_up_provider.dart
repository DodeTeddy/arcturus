import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../models/sign_up_request_body.dart';
import '../services/sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<String> data;

  final SignUpService _signUpService = SignUpService();

  signUp(SignUpRequestBody requestBody) async {
    isLoading = true;
    notifyListeners();

    data = await _signUpService.signUp(requestBody);
    isLoading = false;
    notifyListeners();
  }
}
