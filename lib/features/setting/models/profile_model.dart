import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Data data;

  ProfileModel({
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Vendors vendors;

  Data({
    required this.vendors,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vendors: Vendors.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "vendors": vendors.toJson(),
      };
}

class Vendors {
  String? vendorName;
  String? addressLine1;
  String? addressLine2;
  String? phone;
  String? email;
  String? state;
  String? city;
  String? bankAccount;
  String? bankAddress;
  String? accountNumber;
  String? bankName;
  String? swifCode;
  String? country;
  String? area;
  String? location;
  String? latitude;
  String? longitude;
  String? legalName;

  Vendors({
    required this.vendorName,
    required this.addressLine1,
    required this.addressLine2,
    required this.phone,
    required this.email,
    required this.state,
    required this.city,
    required this.bankAccount,
    required this.bankAddress,
    required this.accountNumber,
    required this.bankName,
    required this.swifCode,
    required this.country,
    required this.area,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.legalName,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
        vendorName: json["vendor_name"] ?? '',
        addressLine1: json["address_line1"] ?? '',
        addressLine2: json["address_line2"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
        bankAccount: json["bank_account"] ?? '',
        bankAddress: json["bank_address"] ?? '',
        accountNumber: json["account_number"] ?? '',
        bankName: json["bank_name"] ?? '',
        swifCode: json["swif_code"] ?? '',
        country: json["country"] ?? '',
        area: json["area"] ?? '',
        location: json["location"] ?? '',
        latitude: json["map_latitude"] ?? '',
        longitude: json["map_longitude"] ?? '',
        legalName: json["vendor_legal_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "vendor_name": vendorName,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "phone": phone,
        "email": email,
        "state": state,
        "city": city,
        "bank_account": bankAccount,
        "bank_address": bankAddress,
        "account_number": accountNumber,
        "bank_name": bankName,
        "swif_code": swifCode,
        "country": country,
        "area": area,
        "location": location,
        "map_latitude": latitude,
        "map_longitude": longitude,
        "vendor_legal_name": legalName,
      };
}
