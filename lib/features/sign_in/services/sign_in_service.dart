import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../models/sign_in_request_body.dart';
import '../models/sign_in_response_model.dart';

class SignInService {
  Future<ResponseModel<SignInResponseModel?>> signIn(SignInRequestBody requestBody) async {
    final Uri url = Uri.parse('${baseUrl}login/travelagent');

    try {
      final response = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode(
          requestBody.convert(),
        ),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        SignInResponseModel data = signInModelFromJson(response.body);
        ResponseModel<SignInResponseModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<SignInResponseModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<SignInResponseModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<String?>> forgotPassword(String email) async {
    final Uri url = Uri.parse('${baseUrl}travelagent/forgetpassword');

    try {
      final response = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode({
          "email": email,
        }),
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
        ResponseModel<String?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<String?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }
}
