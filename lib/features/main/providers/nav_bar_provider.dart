import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int pageIndex = 0;

  onChangeNavBar(newPageIndex) {
    pageIndex = newPageIndex;
    notifyListeners();
  }

  onResetPageIndex() {
    pageIndex = 0;
  }
}
