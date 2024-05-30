import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../models/hotel_list_model.dart';
import '../models/hotel_list_params.dart';
import '../models/hotel_list_response_model.dart';
import '../models/profile_model.dart';
import '../utils/generate_hotel_list_response.dart';

class HomeService {
  Future<ResponseModel<ProfileModel?>> getProfile() async {
    final url = Uri.parse('${baseUrl}agent/myprofile');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

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

  Future<ResponseModel<List<HotelListModel?>>> getHotelList({HotelListParams? params}) async {
    var queryParameters = params == null ? '' : Uri(queryParameters: params.queryParameters());
    final url = Uri.parse('${baseUrl}agent/hotel$queryParameters');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        HotelListResponseModel dataResponse = hotelListResponseModelFromJson(response.body);
        List<HotelListModel> data = dataResponse.data.data
            .map((data) =>
                dataResponse.contractprice.where((contractFilter) => data.contractrate.vendors.id == contractFilter.contractrate.vendors.id))
            .map((contractprice) => contractprice
                .map((contractReduce) => contractReduce)
                .reduce((value, newValue) => double.parse(value.recomPrice!) < double.parse(newValue.recomPrice!) ? value : newValue))
            .toList()
            .asMap()
            .entries
            .map((entry) => HotelListModel(
                  id: entry.value.contractrate.vendors.id ?? 0,
                  idContractrate: dataResponse.data.data[entry.key].contractrate.id ?? 0,
                  hotelImage: hotelImage(entry.value.room.image),
                  hotelName: entry.value.contractrate.vendors.vendorName ?? '-',
                  hotelStar: entry.value.contractrate.vendors.hotelStar ?? '0',
                  hotelLocation: hotelLocation(
                      entry.value.contractrate.vendors.city, entry.value.contractrate.vendors.state, entry.value.contractrate.vendors.country),
                  hotelPrice:
                      hotelPrice(double.parse(entry.value.recomPrice ?? '0'), double.parse(entry.value.contractrate.vendors.systemMarkup ?? '0')),
                  maxRoomPerson: entry.value.room.adults ?? '0',
                ))
            .toList();

        ResponseModel<List<HotelListModel>> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<List<HotelListModel?>> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: [],
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<List<HotelListModel?>> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: [],
      );

      return responseData;
    }
  }
}
