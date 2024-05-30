import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../models/dropdown_country_model.dart';
import '../services/sign_up_service.dart';

class CountryProvider with ChangeNotifier {
  bool isLoading = false;
  late ResponseModel<List<DropdownCountryModel?>> data;

  final SignUpService _signUpService = SignUpService();

  getCountryList() async {
    isLoading = true;
    data = await _signUpService.getCountryList();
    isLoading = false;

    notifyListeners();
  }
}
