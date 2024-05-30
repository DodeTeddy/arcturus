class RoomParams {
  int contractPriceId;
  int contractId;
  double price;
  double priceNoMarkUp;
  int quantity;
  int roomId;

  RoomParams({
    required this.contractPriceId,
    required this.contractId,
    required this.price,
    required this.priceNoMarkUp,
    required this.quantity,
    required this.roomId,
  });
}
