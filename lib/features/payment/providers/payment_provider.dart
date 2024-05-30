import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/response_model.dart';
import '../../../utils/interceptors.dart';
import '../models/saldo_model.dart';
import '../models/total_payment_model.dart';
import '../services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  bool isLoadingTotal = false;
  bool isLoadingSaldo = false;
  bool isLoadingPay = false;
  late ResponseModel<TotalPaymentModel?> totalPayment;
  late ResponseModel<SaldoModel?> saldo;
  late ResponseModel<String> pay;

  final PaymentService _paymentService = PaymentService();

  fetchTotalPayment(int bookingId, BuildContext context) async {
    isLoadingTotal = true;
    totalPayment = await _paymentService.totalPayment(bookingId);
    if (totalPayment.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingTotal = false;

    notifyListeners();
  }

  fetchSaldo(BuildContext context) async {
    isLoadingSaldo = true;
    saldo = await _paymentService.saldo();
    if (saldo.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingSaldo = false;

    notifyListeners();
  }

  payment(int bookingId, BuildContext context) async {
    isLoadingPay = true;
    notifyListeners();

    pay = await _paymentService.pay(bookingId);
    if (pay.statusCode == 401) {
      Timer(const Duration(milliseconds: 1500), () {
        interceptor(context);
      });
    }
    isLoadingPay = false;

    notifyListeners();
  }
}
