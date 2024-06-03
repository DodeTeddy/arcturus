import 'dart:developer';

import 'package:arcturus_mobile_app/features/top_up/models/top_up_model.dart';
import 'package:arcturus_mobile_app/features/top_up/models/top_up_request_model.dart';
import 'package:arcturus_mobile_app/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/key.dart';
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

  Future<ResponseModel<String?>> topUp(TopUpRequestModel requestBody) async {
    String? token = await SecureStorage().readSecureData(bearerToken);
    var uri = Uri.parse('${baseUrl}agent/wallet/topup');

    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['totaltopup'] = requestBody.totaltopup;

    var stream = http.ByteStream(requestBody.image.openRead());
    var length = await requestBody.image.length();
    var multipartFile = http.MultipartFile('image', stream, length, filename: 'bank_transfer_receipt.jpg');

    request.files.add(multipartFile);

    try {
      var response = await request.send();

      int? statusCode = response.statusCode;

      log(statusCode.toString());

      if (statusCode == 200) {
        ResponseModel<String?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: 'Success',
        );

        return responseData;
      } else {
        ResponseModel<String?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: 'Error',
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<String?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.error,
        data: 'Error Catch',
      );

      return responseData;
    }
  }
}
