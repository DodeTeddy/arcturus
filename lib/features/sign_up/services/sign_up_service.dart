import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../models/country_model.dart';
import '../models/dropdown_country_model.dart';
import '../models/sign_up_request_body.dart';

class SignUpService {
  Future<ResponseModel<List<DropdownCountryModel?>>> getCountryList() async {
    final Uri url = Uri.parse('${baseUrl}country/travelagent');

    try {
      final response = await http.get(
        url,
        headers: await headers(),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        CountryModel data = countryModelFromJson(response.body);
        List<DropdownCountryModel> dataConvert = data.data.entries.map((value) => DropdownCountryModel(label: value.value, value: value.key)).toList();
        ResponseModel<List<DropdownCountryModel?>> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: dataConvert,
        );

        return responseData;
      } else {
        ResponseModel<List<DropdownCountryModel?>> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: [],
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<List<DropdownCountryModel?>> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: [],
      );

      return responseData;
    }
  }

  Future<ResponseModel<String>> signUp(SignUpRequestBody requestBody) async {
    final url = Uri.parse('${baseUrl}register/agent');

    try {
      final response = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode(requestBody.convert()),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        ResponseModel<String> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: "Sign up succes...",
        );

        return responseData;
      } else {
        ResponseModel<String> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: statusCode == 422 ? 'The email has already been taken...' : 'Something Error...',
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<String> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: e.toString(),
      );

      return responseData;
    }
  }
}
