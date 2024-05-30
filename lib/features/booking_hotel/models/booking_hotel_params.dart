import '../../detail_hotel/models/room_params.dart';

class BookingHotelParams {
  String checkIn;
  String checkOut;
  int person;
  List<RoomParams> room;
  String totalPrice;
  String vendorId;
  String totalPriceNomarkUp;

  BookingHotelParams({
    required this.checkIn,
    required this.checkOut,
    required this.person,
    required this.room,
    required this.totalPrice,
    required this.vendorId,
    required this.totalPriceNomarkUp,
  });

  Map<String, dynamic> convert() => {
        "checkin": checkIn,
        "checkout": checkOut,
        "person": person,
        "room": room
            .map(
              (e) => {
                "\"contpriceid\"": e.contractPriceId,
                "\"contractid\"": e.contractId,
                "\"price\"": e.price,
                "\"pricenomarkup\"": e.priceNoMarkUp,
                "\"quantity\"": e.quantity,
                "\"roomId\"": e.roomId
              },
            )
            .toList()
            .toString(),
        "totalprice": totalPrice,
        "vendorid": vendorId,
        "totalpricenomarkup": totalPriceNomarkUp
      };
}
