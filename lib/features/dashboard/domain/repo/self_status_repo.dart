import 'package:beep/features/dashboard/domain/entity/get_self_status_response.dart';

abstract class SelfStatusRepo {
  Future<StatusSelfResponeEntity> getselfStatusData();
}
