import 'dart:convert';

TotalPaymentModel totalPaymentModelFromJson(String str) => TotalPaymentModel.fromJson(json.decode(str));

String totalPaymentModelToJson(TotalPaymentModel data) => json.encode(data.toJson());

class TotalPaymentModel {
  Booking booking;

  TotalPaymentModel({
    required this.booking,
  });

  factory TotalPaymentModel.fromJson(Map<String, dynamic> json) => TotalPaymentModel(
        booking: Booking.fromJson(json["booking"]),
      );

  Map<String, dynamic> toJson() => {
        "booking": booking.toJson(),
      };
}

class Booking {
  String price;

  Booking({
    required this.price,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}
