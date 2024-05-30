import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/url.dart';
import '../../../models/enum_response_message.dart';
import '../../../models/response_model.dart';
import '../../../utils/headers_http.dart';
import '../../home/utils/generate_hotel_list_response.dart';
import '../models/booking_detail_model.dart';
import '../models/booking_detail_response_model.dart';
import '../models/booking_hotel_params.dart';
import '../models/booking_hotel_response_model.dart';
import '../models/booking_room_model.dart';
import '../models/booking_store_request_model.dart';
import '../models/destination_model.dart';
import '../models/transportation_model.dart';

class BookingHotelService {
  Future<ResponseModel<BookingHotelResponseModel?>> bookingHotel(BookingHotelParams requestBody) async {
    final Uri url = Uri.parse('${baseUrl}agent/createbooking');

    try {
      final response = await http.post(url,
          headers: await headers(withAuth: true),
          body: jsonEncode(
            requestBody.convert(),
          ));

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        BookingHotelResponseModel data = bookingHotelResponseModelFromJson(response.body);
        ResponseModel<BookingHotelResponseModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: data,
        );

        return responseData;
      } else {
        ResponseModel<BookingHotelResponseModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<BookingHotelResponseModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<BookingDetailModel?>> getDetailBooking(int bookingId) async {
    final Uri url = Uri.parse('${baseUrl}agent/detailbooking/$bookingId');

    try {
      final response = await http.get(
        url,
        headers: await headers(withAuth: true),
      );

      int? statusCode = response.statusCode;

      if (statusCode == 200) {
        BookingDetailResponseModel data = bookingDetailResponseModelFromJson(response.body);
        ResponseModel<BookingDetailModel> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.success,
          data: BookingDetailModel(
            hotelName: data.data.vendor.vendorName ?? '',
            hotelCountry: data.data.vendor.country ?? '',
            hotelLogo: hotelImage(data.data.vendor.logoImg),
            checkIn: data.data.checkinDate.toString(),
            checkOut: data.data.checkoutDate.toString(),
            night: data.data.night ?? '',
            person: data.data.totalGuests ?? '',
            room: data.hotelbooking
                .map((value) => BookingRoomlModel(
                      roomName: value.roomName ?? '',
                      roomTotal: value.totalRoom ?? '',
                      roomPrice: value.price ?? '0',
                    ))
                .toList(),
            totalPrice: data.data.price ?? '0',
            destination: [
              ...[DestinationModel(id: 0, destination: 'All')],
              ...data.destination.map(
                (value) => DestinationModel(
                  id: value.id ?? 0,
                  destination: value.destination ?? '',
                ),
              )
            ],
            transportation: data.transport
                .map(
                  (value) => TransportationModel(
                    id: value.id ?? 0,
                    transportName: value.typeCar ?? '',
                    transportSeat: value.transportSet ?? '',
                    transportPrice: ((double.parse(value.price ?? '0') + double.parse(value.agenttransport.markup ?? '0'))).toString(),
                    transportDestination: value.transportdestination.destination ?? '',
                  ),
                )
                .toList(),
          ),
        );

        return responseData;
      } else {
        ResponseModel<BookingDetailModel?> responseData = ResponseModel(
          statusCode: statusCode,
          message: ResponseMessage.error,
          data: null,
        );

        return responseData;
      }
    } catch (e) {
      ResponseModel<BookingDetailModel?> responseData = ResponseModel(
        statusCode: null,
        message: ResponseMessage.errorCatch,
        data: null,
      );

      return responseData;
    }
  }

  Future<ResponseModel<String>> bookingStore(BookingStoreRequestModel requestBody, int id) async {
    final Uri url = Uri.parse('${baseUrl}agent/bookingstore/$id');

    try {
      final response = await http.post(
        url,
        headers: await headers(withAuth: true),
        body: jsonEncode(
          requestBody.convert(),
        ),
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
        data: 'Error Catch',
      );

      return responseData;
    }
  }
}
