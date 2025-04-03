import 'package:beep/features/dashboard/domain/entity/status_response_entity.dart';

abstract class StatusRepo {
  Future<StatusChatResponeEntity> getUserData();
}
