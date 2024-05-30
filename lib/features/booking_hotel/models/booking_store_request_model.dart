import 'dart:convert';

String bookingStoreRequestModelConvert(BookingStoreRequestModel data) => json.encode(data.convert());

class BookingStoreRequestModel {
  String firstname;
  String lastname;
  String email;
  String phone;
  String addressLine1;
  String addressLine2;
  String zipcode;
  String city;
  String country;
  String state;
  String specialRequest;
  int idtransport;
  String timepickup;
  String flight;
  String datepickup;

  BookingStoreRequestModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.zipcode,
    required this.city,
    required this.country,
    required this.state,
    required this.specialRequest,
    required this.idtransport,
    required this.timepickup,
    required this.flight,
    required this.datepickup,
  });

  Map<String, dynamic> convert() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "zipcode": zipcode,
        "city": city,
        "country": country,
        "state": state,
        "special_request": specialRequest,
        "idtransport": idtransport,
        "timepickup": timepickup,
        "flight": flight,
        "datepickup": datepickup,
      };
}
