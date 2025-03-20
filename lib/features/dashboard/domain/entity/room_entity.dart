import 'package:chat_app/features/dashboard/data/model/room_model.dart';

class RoomResponseEntity {
  String? status;
  List<RoomData>? data;

  RoomResponseEntity({
    this.status,
    this.data,
  });
}
