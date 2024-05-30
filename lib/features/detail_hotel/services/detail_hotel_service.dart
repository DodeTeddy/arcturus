import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../../home/utils/generate_hotel_list_response.dart';
import '../models/available_room_model.dart';
import '../models/detail_hotel_model.dart';
import '../models/detail_hotel_params.dart';
import '../models/detail_hotel_response_model.dart';
import '../models/room_rate_model.dart';

class DetailHotelService {
  Future<ResponseModel<DetailHotelModel?>> getDetailHotel({DetailHotelParams? params, required int id}) async {
    var queryParameters = params == null ? '' : Uri(queryParameters: params.queryParameters());
    final url = Uri.parse('${baseUrl}agent/hoteldetail/$id$queryParameters');

    try {
      var response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        DetailHotelResponseModel dataResponse = detailHotelResponseModeFromJson(response.body);

        DetailHotelModel data = DetailHotelModel(
          vendorId: dataResponse.vendordetail.id,
          images: dataResponse.slider.isNotEmpty ? dataResponse.slider.map((e) => '$imageBaseUrl${e.image}').toList() : [],
          market: dataResponse.vendordetail.marketcountry ?? [],
          hotelStar: dataResponse.vendordetail.hotelStar ?? '',
          hotelName: dataResponse.vendordetail.vendorName ?? '',
          hotelLogo: hotelImage(dataResponse.vendordetail.logoImg),
          hotelCountry: dataResponse.vendordetail.country ?? '',
          hotelHighlights: dataResponse.vendordetail.highlight ?? '',
          depositPolicy: dataResponse.contractprice[0].contractrate.depositPolicy ?? '',
          cencellationPolicy: dataResponse.contractprice[0].contractrate.cencellationPolicy ?? '',
          availableRoom: dataResponse.roomtype
              .map(
                (e) => AvailableRoomModel(
                  id: e.id as int,
                  roomName: e.ratedesc ?? '',
                  roomImage: hotelImage(e.featureImage),
                  roomExplanation: e.content ?? '',
                  room: dataResponse.contractprice
                      .where((element) => e.id == element.room.id)
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (e) => RoomRateModel(
                          roomId: e.value.room.id as int,
                          contractId: e.value.id as int,
                          contractPriceId: dataResponse.contractprice[e.key].id as int,
                          vendorId: e.value.contractrate.vendors.id as int,
                          minStay: e.value.contractrate.minStay ?? '',
                          roomPrice: e.value.recomPrice ?? '',
                          markUpPrice: e.value.contractrate.vendors.systemMarkup ?? '',
                          benefit: e.value.contractrate.benefitPolicy ?? '',
                          roomAllow: e.value.room.roomAllow ?? '',
                          quantity: 0,
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );

        ResponseModel<DetailHotelModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );
        return responseData;
      } else {
        ResponseModel<DetailHotelModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<DetailHotelModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }
}
