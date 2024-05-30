import 'available_room_model.dart';

class DetailHotelModel {
  int vendorId;
  List<String> images;
  List<String> market;
  String hotelStar;
  String hotelName;
  String hotelLogo;
  String hotelCountry;
  String hotelHighlights;
  String depositPolicy;
  String cencellationPolicy;
  List<AvailableRoomModel> availableRoom;

  DetailHotelModel({
    required this.vendorId,
    required this.images,
    required this.market,
    required this.hotelStar,
    required this.hotelName,
    required this.hotelLogo,
    required this.hotelCountry,
    required this.hotelHighlights,
    required this.depositPolicy,
    required this.cencellationPolicy,
    required this.availableRoom,
  });
}
