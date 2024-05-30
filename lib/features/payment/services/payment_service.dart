import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../models/saldo_model.dart';
import '../models/total_payment_model.dart';

class PaymentService {
  Future<ResponseModel<TotalPaymentModel?>> totalPayment(int bookingId) async {
    final Uri url = Uri.parse('${baseUrl}agent/paymentbookingpage/$bookingId');

    try {
      final response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        TotalPaymentModel data = totalPaymentModelFromJson(response.body);
        ResponseModel<TotalPaymentModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<TotalPaymentModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<TotalPaymentModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<SaldoModel?>> saldo() async {
    final Uri url = Uri.parse('${baseUrl}agent/myprofile');

    try {
      final response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        SaldoModel data = saldoModelFromJson(response.body);
        ResponseModel<SaldoModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<SaldoModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<SaldoModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<String>> pay(int bookingId) async {
    final Uri url = Uri.parse('${baseUrl}agent/wallet/pay/$bookingId');

    try {
      final response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        ResponseModel<String> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: 'Success',
        );

        return responseData;
      } else {
        ResponseModel<String> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: 'Error',
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<String> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: '',
      );

      return responseData;
    }
  }
}
