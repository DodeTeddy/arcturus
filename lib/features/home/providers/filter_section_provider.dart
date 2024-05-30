import 'package:flutter/material.dart';

class FilterSectionProvider with ChangeNotifier {
  String search = '';
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  int person = 2;
  String country = '';
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

  void setCountry(String newCountry) {
    country = newCountry;
    notifyListeners();
  }

  void setSort(String newSort) {
    sort = newSort;
    notifyListeners();
  }

  void resetFilter() {
    search = '';
    checkIn = DateTime.now();
    checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    person = 2;
    country = '';
    sort = '';
    notifyListeners();
  }

  void resetFilterInit() {
    search = '';
    checkIn = DateTime.now();
    checkOut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    person = 2;
    country = '';
    sort = '';
  }
}
