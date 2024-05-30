import 'dart:convert';

String updateProfileRequestBody(UpdateProfileRequestBody data) => json.encode(data.convert());

class UpdateProfileRequestBody {
  String city;
  String state;
  String country;
  String area;
  String location;
  String busisnessname;
  String legalname;
  String address;
  String address2;
  String phone;
  String email;
  String latitude;
  String longitude;
  String bank;
  String bankaccount;
  String swifcode;
  String bankaddress;
  String accountnumber;
  String distribute;

  UpdateProfileRequestBody({
    required this.city,
    required this.state,
    required this.country,
    required this.area,
    required this.location,
    required this.busisnessname,
    required this.legalname,
    required this.address,
    required this.address2,
    required this.phone,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.bank,
    required this.bankaccount,
    required this.swifcode,
    required this.bankaddress,
    required this.accountnumber,
    required this.distribute,
  });

  Map<String, dynamic> convert() => {
        "city": city,
        "state": state,
        "country": country,
        "area": area,
        "location": location,
        "busisnessname": busisnessname,
        "legalname": legalname,
        "address": address,
        "address2": address2,
        "phone": phone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "bank": bank,
        "bankaccount": bankaccount,
        "swifcode": swifcode,
        "bankaddress": bankaddress,
        "accountnumber": accountnumber,
        "distribute": distribute,
      };
}
