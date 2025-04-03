import 'package:beep/features/dashboard/data/model/get_self_status_reponse.dart';
import 'package:beep/features/dashboard/data/model/status_reponse.dart';

class StatusSelfResponeEntity {
  String? status;
  String? message;
  StatusUserData? data;

  StatusSelfResponeEntity({
    this.status,
    this.message,
    this.data,
  });
}
