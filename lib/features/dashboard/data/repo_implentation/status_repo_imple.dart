import 'package:beep/features/dashboard/data/datasource/search_ds.dart';
import 'package:beep/features/dashboard/data/datasource/status_ds.dart';
import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/features/dashboard/domain/entity/status_response_entity.dart';
import 'package:beep/features/dashboard/domain/repo/status_repo.dart';

class StatusRepoImple extends StatusRepo {
  final StatusDataSource statusDataSource;
  StatusRepoImple({required this.statusDataSource});
  @override
  Future<StatusChatResponeEntity> getUserData() {
    return statusDataSource.statusApiCall();
  }
}
