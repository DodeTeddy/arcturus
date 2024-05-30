import 'package:flutter/material.dart';

import '../models/transportation_model.dart';

class AddTransportProvider with ChangeNotifier {
  TransportationModel? transportationdata;
  TimeOfDay timepickup = TimeOfDay.now();
  String? flight;
  DateTime datepickup = DateTime.now();

  void addTransportation(TransportationModel transportation) {
    transportationdata = transportation;
    notifyListeners();
  }

  void addTimePickUp(TimeOfDay time) {
    timepickup = time;
    notifyListeners();
  }

  void addFlight(String newFlight) {
    flight = newFlight;
    notifyListeners();
  }

  void addDatePickUp(DateTime newDatepickup) {
    datepickup = newDatepickup;
    notifyListeners();
  }

  void reset() {
    transportationdata = null;
    timepickup = TimeOfDay.now();
    flight = null;
    datepickup = DateTime.now();
  }
}
