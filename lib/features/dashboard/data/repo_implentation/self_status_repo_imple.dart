import 'package:beep/features/dashboard/data/datasource/self_status_ds.dart';
import 'package:beep/features/dashboard/domain/entity/get_self_status_response.dart';
import 'package:beep/features/dashboard/domain/repo/self_status_repo.dart';

class SelfStatusRepoImple extends SelfStatusRepo {
  final SelfStatusDs selfStatusDs;
  SelfStatusRepoImple({required this.selfStatusDs});
  @override
  Future<StatusSelfResponeEntity> getselfStatusData() async {
    return await selfStatusDs.statusApiCall();
  }
}
