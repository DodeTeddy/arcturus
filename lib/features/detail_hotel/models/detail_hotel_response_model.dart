// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

DetailHotelResponseModel detailHotelResponseModeFromJson(String str) => DetailHotelResponseModel.fromJson(json.decode(str));

String detailHotelResponseModeToJson(DetailHotelResponseModel data) => json.encode(data.toJson());

class DetailHotelResponseModel {
  List<Slider> slider;
  List<Roomtype> roomtype;
  Vendordetail vendordetail;
  List<Contractprice> contractprice;

  DetailHotelResponseModel({
    required this.slider,
    required this.roomtype,
    required this.vendordetail,
    required this.contractprice,
  });

  factory DetailHotelResponseModel.fromJson(Map<String, dynamic> json) => DetailHotelResponseModel(
        slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
        roomtype: List<Roomtype>.from(json["roomtype"].map((x) => Roomtype.fromJson(x))),
        vendordetail: Vendordetail.fromJson(json["vendordetail"]),
        contractprice: List<Contractprice>.from(json["contractprice"].map((x) => Contractprice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
        "roomtype": List<dynamic>.from(roomtype.map((x) => x.toJson())),
        "vendordetail": vendordetail.toJson(),
        "contractprice": List<dynamic>.from(contractprice.map((x) => x.toJson())),
      };
}

class Contractprice {
  int? id;
  String? recomPrice;
  Contractrate contractrate;
  Room room;

  Contractprice({
    required this.id,
    required this.recomPrice,
    required this.contractrate,
    required this.room,
  });

  factory Contractprice.fromJson(Map<String, dynamic> json) => Contractprice(
        id: json["id"],
        recomPrice: json["recom_price"],
        contractrate: Contractrate.fromJson(json["contractrate"]),
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recom_price": recomPrice,
        "contractrate": contractrate.toJson(),
        "room": room.toJson(),
      };
}

class Contractrate {
  int? id;
  String? minStay;
  String? benefitPolicy;
  String? depositPolicy;
  String? cencellationPolicy;
  Vendors vendors;

  Contractrate({
    required this.id,
    required this.minStay,
    required this.benefitPolicy,
    required this.depositPolicy,
    required this.cencellationPolicy,
    required this.vendors,
  });

  factory Contractrate.fromJson(Map<String, dynamic> json) => Contractrate(
        id: json["id"],
        minStay: json["min_stay"],
        benefitPolicy: json["benefit_policy"],
        depositPolicy: json["deposit_policy"],
        cencellationPolicy: json["cencellation_policy"],
        vendors: Vendors.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "min_stay": minStay,
        "benefit_policy": benefitPolicy,
        "deposit_policy": depositPolicy,
        "cencellation_policy": cencellationPolicy,
        "vendors": vendors.toJson(),
      };
}

class Vendors {
  int? id;
  String? systemMarkup;

  Vendors({
    required this.id,
    required this.systemMarkup,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
        id: json["id"],
        systemMarkup: json["system_markup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "system_markup": systemMarkup,
      };
}

class Room {
  int? id;
  String? roomAllow;

  Room({
    required this.id,
    required this.roomAllow,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        roomAllow: json["room_allow"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_allow": roomAllow,
      };
}

class Roomtype {
  int? id;
  String? ratedesc;
  String? featureImage;
  String? content;

  Roomtype({
    required this.id,
    required this.ratedesc,
    required this.featureImage,
    required this.content,
  });

  factory Roomtype.fromJson(Map<String, dynamic> json) => Roomtype(
        id: json["id"],
        ratedesc: json["ratedesc"],
        featureImage: json["feature_image"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ratedesc": ratedesc,
        "feature_image": featureImage,
        "content": content,
      };
}

class Slider {
  String? image;

  Slider({
    required this.image,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class Vendordetail {
  int id;
  String? logoImg;
  String? vendorName;
  String? country;
  List<String>? marketcountry;
  String? hotelStar;
  String? highlight;

  Vendordetail({
    required this.id,
    required this.logoImg,
    required this.vendorName,
    required this.country,
    this.marketcountry,
    required this.hotelStar,
    required this.highlight,
  });

  factory Vendordetail.fromJson(Map<String, dynamic> json) => Vendordetail(
        id: json["id"],
        logoImg: json["logo_img"],
        vendorName: json["vendor_name"],
        country: json["country"],
        marketcountry: json["marketcountry"] != null ? List<String>.from(json["marketcountry"].map((x) => x)) : null,
        hotelStar: json["hotel_star"],
        highlight: json["highlight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_img": logoImg,
        "vendor_name": vendorName,
        "country": country,
        "marketcountry": marketcountry,
        "hotel_star": hotelStar,
        "highlight": highlight,
      };
}
