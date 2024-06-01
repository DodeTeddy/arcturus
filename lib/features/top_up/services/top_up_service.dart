import 'dart:developer';

import 'package:arcturus_mobile_app/features/top_up/models/top_up_model.dart';
import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';

class TopUpService {
  Future<ResponseModel<TopUpModel?>> getTopUpHistory() async {
    final url = Uri.parse('${baseUrl}agent/wallet');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      log(response.body);

      if (statusCode == 200) {
        TopUpModel data = topUpModelFromJson(response.body);
        ResponseModel<TopUpModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<TopUpModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<TopUpModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }
}
