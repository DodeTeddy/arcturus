import 'dart:convert';

BookingHotelResponseModel bookingHotelResponseModelFromJson(String str) => BookingHotelResponseModel.fromJson(json.decode(str));

String bookingHotelResponseModelToJson(BookingHotelResponseModel data) => json.encode(data.toJson());

class BookingHotelResponseModel {
  int bookingId;

  BookingHotelResponseModel({
    required this.bookingId,
  });

  factory BookingHotelResponseModel.fromJson(Map<String, dynamic> json) => BookingHotelResponseModel(
        bookingId: json["booking_id"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
      };
}
