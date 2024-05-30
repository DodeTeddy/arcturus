import '../../../constants/url.dart';

String hotelImage(String? imageUrl) {
  return imageUrl != null ? '$imageBaseUrl$imageUrl' : '';
}

String hotelLocation(String? city, String? state, String? country) {
  return city != null || state != null || country != null ? '$city, $state, $country' : '-';
}

String hotelPrice(double recomPrice, double systemMarkup) {
  return (recomPrice + systemMarkup).toString();
}
