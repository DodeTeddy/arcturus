import 'room_rate_model.dart';

class AvailableRoomModel {
  int id;
  String roomName;
  String roomImage;
  String roomExplanation;
  List<RoomRateModel> room;

  AvailableRoomModel({
    required this.id,
    required this.roomName,
    required this.roomImage,
    required this.roomExplanation,
    required this.room,
  });
}
