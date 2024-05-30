import 'dart:convert';

SignInResponseModel signInModelFromJson(String str) => SignInResponseModel.fromJson(json.decode(str));

String signInModelToJson(SignInResponseModel data) => json.encode(data.toJson());

class SignInResponseModel {
  User user;
  String token;

  SignInResponseModel({
    required this.user,
    required this.token,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  String isActive;

  User({
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "is_active": isActive,
      };
}
