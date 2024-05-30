import 'booking_room_model.dart';
import 'destination_model.dart';
import 'transportation_model.dart';

class BookingDetailModel {
  String hotelName;
  String hotelCountry;
  String hotelLogo;
  String checkIn;
  String checkOut;
  String night;
  String person;
  List<BookingRoomlModel> room;
  String totalPrice;
  List<DestinationModel> destination;
  List<TransportationModel> transportation;

  BookingDetailModel({
    required this.hotelName,
    required this.hotelCountry,
    required this.hotelLogo,
    required this.checkIn,
    required this.checkOut,
    required this.night,
    required this.person,
    required this.room,
    required this.totalPrice,
    required this.destination,
    required this.transportation,
  });
}
