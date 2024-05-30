import 'dart:convert';

HotelListResponseModel hotelListResponseModelFromJson(String str) => HotelListResponseModel.fromJson(json.decode(str));

String hotelListResponseModelToJson(HotelListResponseModel data) => json.encode(data.toJson());

class HotelListResponseModel {
  Data data;
  List<Contractprice> contractprice;

  HotelListResponseModel({
    required this.data,
    required this.contractprice,
  });

  factory HotelListResponseModel.fromJson(Map<String, dynamic> json) => HotelListResponseModel(
        data: Data.fromJson(json["data"]),
        contractprice: List<Contractprice>.from(json["contractprice"].map((x) => Contractprice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "contractprice": List<dynamic>.from(contractprice.map((x) => x.toJson())),
      };
}

class Contractprice {
  String? recomPrice;
  ContractpriceContractrate contractrate;
  Room room;

  Contractprice({
    required this.recomPrice,
    required this.contractrate,
    required this.room,
  });

  factory Contractprice.fromJson(Map<String, dynamic> json) => Contractprice(
        recomPrice: json["recom_price"],
        contractrate: ContractpriceContractrate.fromJson(json["contractrate"]),
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "recom_price": recomPrice,
        "contractrate": contractrate.toJson(),
        "room": room.toJson(),
      };
}

class ContractpriceContractrate {
  int? idContractrate;
  PurpleVendors vendors;

  ContractpriceContractrate({
    required this.idContractrate,
    required this.vendors,
  });

  factory ContractpriceContractrate.fromJson(Map<String, dynamic> json) => ContractpriceContractrate(
        idContractrate: json["id"],
        vendors: PurpleVendors.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "id": idContractrate,
        "vendors": vendors.toJson(),
      };
}

class PurpleVendors {
  int? id;
  String? vendorName;
  String? country;
  String? state;
  String? city;
  String? hotelStar;
  String? systemMarkup;

  PurpleVendors({
    required this.id,
    required this.vendorName,
    required this.country,
    required this.state,
    required this.city,
    required this.hotelStar,
    required this.systemMarkup,
  });

  factory PurpleVendors.fromJson(Map<String, dynamic> json) => PurpleVendors(
        id: json["id"],
        vendorName: json["vendor_name"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        hotelStar: json["hotel_star"],
        systemMarkup: json["system_markup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_name": vendorName,
        "country": country,
        "state": state,
        "city": city,
        "hotel_star": hotelStar,
        "system_markup": systemMarkup,
      };
}

class Room {
  String? adults;
  String? image;

  Room({
    required this.adults,
    required this.image,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        adults: json["adults"],
        image: json["feature_image"],
      );

  Map<String, dynamic> toJson() => {
        "adults": adults,
        "feature_image": image,
      };
}

class Data {
  List<Datum> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  DatumContractrate contractrate;

  Datum({
    required this.contractrate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        contractrate: DatumContractrate.fromJson(json["contractrate"]),
      );

  Map<String, dynamic> toJson() => {
        "contractrate": contractrate.toJson(),
      };
}

class DatumContractrate {
  int? id;
  FluffyVendors vendors;

  DatumContractrate({
    required this.id,
    required this.vendors,
  });

  factory DatumContractrate.fromJson(Map<String, dynamic> json) => DatumContractrate(
        id: json["id"],
        vendors: FluffyVendors.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendors": vendors.toJson(),
      };
}

class FluffyVendors {
  int? id;

  FluffyVendors({
    required this.id,
  });

  factory FluffyVendors.fromJson(Map<String, dynamic> json) => FluffyVendors(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
