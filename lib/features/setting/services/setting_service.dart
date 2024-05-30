import 'dart:convert';
import 'dart:developer';

import '../models/update_profile_request_body.dart';
import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../models/profile_model.dart';

class SettingService {
  Future<ResponseModel<String?>> signOut() async {
    final Uri url = Uri.parse('${baseUrl}logout/travelagent');

    try {
      final response = await http.post(
        url,
        headers: await headers(),
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

  Future<ResponseModel<String?>> updatePassword(String password) async {
    final Uri url = Uri.parse('${baseUrl}agent/myprofile/updatepassword');

    try {
      final response = await http.post(
        url,
        headers: await headers(withAuth: true),
        body: jsonEncode({
          "password": password,
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

  Future<ResponseModel<ProfileModel?>> getProfile() async {
    final url = Uri.parse('${baseUrl}agent/myprofile');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      log(response.body);

      if (statusCode == 200) {
        ProfileModel data = profileModelFromJson(response.body);
        ResponseModel<ProfileModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<ProfileModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<ProfileModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<String?>> updateProfile(UpdateProfileRequestBody requestBody) async {
    final Uri url = Uri.parse('${baseUrl}agent/myprofile/update');

    try {
      final response = await http.post(
        url,
        headers: await headers(withAuth: true),
        body: jsonEncode(
          updateProfileRequestBody(requestBody),
        ),
      );

      int? statusCode = response.statusCode;

      log(response.body);
      log(
        jsonEncode(
          updateProfileRequestBody(requestBody),
        ),
      );

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
