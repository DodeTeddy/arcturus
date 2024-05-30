import '../constants/key.dart';
import 'secure_storage.dart';

Future<Map<String, String>> headers({bool withAuth = false}) async {
  String? token = await SecureStorage().readSecureData(bearerToken);

  if (withAuth) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  return {
    'Content-Type': 'application/json',
  };
}
