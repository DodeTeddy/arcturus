import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  Data data;
  String? booking;
  int? success;
  int? pending;
  List<Getbooking> getbooking;
  int? totalroom;
  List<Transport> transport;

  DashboardModel({
    required this.data,
    required this.booking,
    required this.success,
    required this.pending,
    required this.getbooking,
    required this.totalroom,
    required this.transport,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        data: Data.fromJson(json["data"]),
        booking: json["booking"],
        success: json["success"],
        pending: json["pending"],
        getbooking: List<Getbooking>.from(json["getbooking"].map((x) => Getbooking.fromJson(x))),
        totalroom: json["totalroom"],
        transport: List<Transport>.from(json["transport"].map((x) => Transport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "booking": booking,
        "success": success,
        "pending": pending,
        "getbooking": List<dynamic>.from(getbooking.map((x) => x.toJson())),
        "totalroom": totalroom,
        "transport": List<dynamic>.from(transport.map((x) => x.toJson())),
      };
}

class Data {
  String? saldo;

  Data({
    required this.saldo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "saldo": saldo,
      };
}

class Getbooking {
  int? id;
  DateTime bookingDate;
  DateTime checkinDate;
  DateTime checkoutDate;
  String? night;
  String? price;
  String? bookingStatus;
  Vendor vendor;

  Getbooking({
    required this.id,
    required this.bookingDate,
    required this.checkinDate,
    required this.checkoutDate,
    required this.night,
    required this.price,
    required this.bookingStatus,
    required this.vendor,
  });

  factory Getbooking.fromJson(Map<String, dynamic> json) => Getbooking(
        id: json["id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        checkinDate: DateTime.parse(json["checkin_date"]),
        checkoutDate: DateTime.parse(json["checkout_date"]),
        night: json["night"],
        price: json["price"],
        bookingStatus: json["booking_status"],
        vendor: Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "checkin_date":
            "${checkinDate.year.toString().padLeft(4, '0')}-${checkinDate.month.toString().padLeft(2, '0')}-${checkinDate.day.toString().padLeft(2, '0')}",
        "checkout_date":
            "${checkoutDate.year.toString().padLeft(4, '0')}-${checkoutDate.month.toString().padLeft(2, '0')}-${checkoutDate.day.toString().padLeft(2, '0')}",
        "night": night,
        "price": price,
        "booking_status": bookingStatus,
        "vendor": vendor.toJson(),
      };
}

class Vendor {
  String? vendorName;

  Vendor({
    required this.vendorName,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorName: json["vendor_name"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_name": vendorName,
      };
}

class Transport {
  String? bookingId;
  String? totalPrice;

  Transport({
    required this.bookingId,
    required this.totalPrice,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        bookingId: json["booking_id"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "total_price": totalPrice,
      };
}
