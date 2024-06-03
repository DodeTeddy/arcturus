import 'dart:convert';
import 'dart:io';

String topUpRequestModelToJson(TopUpRequestModel data) => json.encode(data.requestBody());

class TopUpRequestModel {
  String totaltopup;
  File image;

  TopUpRequestModel({
    required this.totaltopup,
    required this.image,
  });

  Map<String, dynamic> requestBody() => {
        "totaltopup": totaltopup,
        "image": image,
      };
}
