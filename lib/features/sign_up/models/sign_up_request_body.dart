class SignUpRequestBody {
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String busisnesName;
  String companyName;
  String address;
  String city;
  String state;
  String country;

  SignUpRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.busisnesName,
    required this.companyName,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  Map<String, dynamic> convert() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "busisnes_name": busisnesName,
        "company_name": companyName,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
      };
}
