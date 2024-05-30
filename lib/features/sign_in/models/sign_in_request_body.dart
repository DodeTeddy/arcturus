class SignInRequestBody {
  String email;
  String password;

  SignInRequestBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> convert() => {
        "email": email,
        "password": password,
      };
}
