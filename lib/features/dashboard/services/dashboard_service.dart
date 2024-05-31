import 'package:arcturus_mobile_app/features/dashboard/models/dashboard_model.dart';
import 'package:arcturus_mobile_app/models/response_model.dart';
import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../utils/headers_http.dart';

class DashboardService {
  Future<ResponseModel<DashboardModel?>> getDashboardData() async {
    final url = Uri.parse('${baseUrl}dashboard/agent');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        DashboardModel data = dashboardModelFromJson(response.body);

        ResponseModel<DashboardModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );
        return responseData;
      } else {
        ResponseModel<DashboardModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<DashboardModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }
}
