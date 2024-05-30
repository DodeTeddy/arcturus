import 'dart:convert';

BookingDetailResponseModel bookingDetailResponseModelFromJson(String str) => BookingDetailResponseModel.fromJson(json.decode(str));

String bookingDetailResponseModelToJson(BookingDetailResponseModel data) => json.encode(data.toJson());

class BookingDetailResponseModel {
  Data data;
  List<Hotelbooking> hotelbooking;
  List<Transport> transport;
  List<Destination> destination;

  BookingDetailResponseModel({
    required this.data,
    required this.hotelbooking,
    required this.transport,
    required this.destination,
  });

  factory BookingDetailResponseModel.fromJson(Map<String, dynamic> json) => BookingDetailResponseModel(
        data: Data.fromJson(json["data"]),
        hotelbooking: List<Hotelbooking>.from(json["hotelbooking"].map((x) => Hotelbooking.fromJson(x))),
        transport: List<Transport>.from(json["transport"].map((x) => Transport.fromJson(x))),
        destination: List<Destination>.from(json["destination"].map((x) => Destination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "hotelbooking": List<dynamic>.from(hotelbooking.map((x) => x.toJson())),
        "transport": List<dynamic>.from(transport.map((x) => x.toJson())),
        "destination": List<dynamic>.from(destination.map((x) => x.toJson())),
      };
}

class Data {
  DateTime checkinDate;
  DateTime checkoutDate;
  String? night;
  String? totalGuests;
  String? price;
  Vendor vendor;

  Data({
    required this.checkinDate,
    required this.checkoutDate,
    required this.night,
    required this.totalGuests,
    required this.price,
    required this.vendor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        checkinDate: DateTime.parse(json["checkin_date"]),
        checkoutDate: DateTime.parse(json["checkout_date"]),
        night: json["night"],
        totalGuests: json["total_guests"],
        price: json["price"],
        vendor: Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "checkin_date":
            "${checkinDate.year.toString().padLeft(4, '0')}-${checkinDate.month.toString().padLeft(2, '0')}-${checkinDate.day.toString().padLeft(2, '0')}",
        "checkout_date":
            "${checkoutDate.year.toString().padLeft(4, '0')}-${checkoutDate.month.toString().padLeft(2, '0')}-${checkoutDate.day.toString().padLeft(2, '0')}",
        "night": night,
        "total_guests": totalGuests,
        "price": price,
        "vendor": vendor.toJson(),
      };
}

class Vendor {
  String? logoImg;
  String? vendorName;
  String? country;

  Vendor({
    required this.logoImg,
    required this.vendorName,
    required this.country,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        logoImg: json["logo_img"],
        vendorName: json["vendor_name"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "logo_img": logoImg,
        "vendor_name": vendorName,
        "country": country,
      };
}

class Destination {
  int? id;
  String? destination;

  Destination({
    required this.id,
    required this.destination,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["id"],
        destination: json["destination"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "destination": destination,
      };
}

class Hotelbooking {
  String? price;
  String? roomName;
  String? totalRoom;

  Hotelbooking({
    required this.price,
    required this.roomName,
    required this.totalRoom,
  });

  factory Hotelbooking.fromJson(Map<String, dynamic> json) => Hotelbooking(
        price: json["price"],
        roomName: json["room_name"],
        totalRoom: json["total_room"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "room_name": roomName,
        "total_room": totalRoom,
      };
}

class Transport {
  int? id;
  String? typeCar;
  String? price;
  String? transportSet;
  Destination transportdestination;
  Agenttransport agenttransport;

  Transport({
    required this.id,
    required this.typeCar,
    required this.price,
    required this.transportSet,
    required this.transportdestination,
    required this.agenttransport,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        id: json["id"],
        typeCar: json["type_car"],
        price: json["price"],
        transportSet: json["set"],
        transportdestination: Destination.fromJson(json["transportdestination"]),
        agenttransport: Agenttransport.fromJson(json["agenttransport"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_car": typeCar,
        "price": price,
        "set": transportSet,
        "transportdestination": transportdestination.toJson(),
        "agenttransport": agenttransport.toJson(),
      };
}

class Agenttransport {
  String? markup;

  Agenttransport({
    required this.markup,
  });

  factory Agenttransport.fromJson(Map<String, dynamic> json) => Agenttransport(
        markup: json["markup"],
      );

  Map<String, dynamic> toJson() => {
        "markup": markup,
      };
}
