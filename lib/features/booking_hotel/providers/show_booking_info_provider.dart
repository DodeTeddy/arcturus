import 'package:flutter/material.dart';

class ShowBookingInfoProvider with ChangeNotifier {
  bool isShow = true;

  setIsShow() {
    isShow = !isShow;
    notifyListeners();
  }
}
