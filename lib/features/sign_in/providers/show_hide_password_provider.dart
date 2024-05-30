import 'package:flutter/material.dart';

class ShowHidePasswordProvider with ChangeNotifier {
  bool _isHidePassword = true;

  bool get isHidePassword => _isHidePassword;

  void visibilityOnTap() {
    _isHidePassword = !_isHidePassword;
    notifyListeners();
  }
}
