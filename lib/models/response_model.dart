import 'enum_response_message.dart';

class ResponseModel<T> {
  final int? statusCode;
  final ResponseMessage? message;
  final T data;

  ResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
