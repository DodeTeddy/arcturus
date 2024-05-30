import 'dart:convert';

SaldoModel saldoModelFromJson(String str) => SaldoModel.fromJson(json.decode(str));

String saldoModelToJson(SaldoModel data) => json.encode(data.toJson());

class SaldoModel {
  Data data;

  SaldoModel({
    required this.data,
  });

  factory SaldoModel.fromJson(Map<String, dynamic> json) => SaldoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String saldo;

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
