import 'package:flutter/material.dart';

class HotelHighlightProvider with ChangeNotifier {
  bool isExpand = false;

  void setIsExpand() {
    isExpand = !isExpand;
    notifyListeners();
  }
}
