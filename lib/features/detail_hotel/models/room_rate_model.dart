// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomRateModel {
  int roomId;
  int contractId;
  int contractPriceId;
  int vendorId;
  String minStay;
  String roomPrice;
  String markUpPrice;
  String benefit;
  String roomAllow;
  int quantity;

  RoomRateModel({
    required this.roomId,
    required this.contractId,
    required this.contractPriceId,
    required this.vendorId,
    required this.minStay,
    required this.roomPrice,
    required this.markUpPrice,
    required this.benefit,
    required this.roomAllow,
    required this.quantity,
  });
}
