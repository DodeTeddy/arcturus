import 'package:flutter/material.dart';

class HotelListParamsProvider with ChangeNotifier {
  String search = '';
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  int person = 2;
  int page = 1;
  String sort = '';

  void setSearch(String newSearch) {
    search = newSearch;
    notifyListeners();
  }

  void setCheckIn(DateTime newCheckIn) {
    checkIn = newCheckIn;
    notifyListeners();
  }

  void setCheckOut(DateTime newCheckOut) {
    checkOut = newCheckOut;
    notifyListeners();
  }

  void setPerson(int newPerson) {
    person = newPerson;
    notifyListeners();
  }

  void setPage() {
    page++;
    notifyListeners();
  }

  void setSort(String newSort) {
    sort = newSort;
    notifyListeners();
  }

  void resetParams() {
    search = '';
    checkIn = DateTime.now();
    checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    person = 2;
    page = 1;
    sort = '';
    notifyListeners();
  }

  void resetParamsInit() {
    search = '';
    checkIn = DateTime.now();
    checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    person = 2;
    page = 1;
    sort = '';
  }
}
