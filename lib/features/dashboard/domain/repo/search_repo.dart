import 'package:beep/features/dashboard/domain/entity/search_entity.dart';

abstract class SearchRepo {
  Future<SearchResponseEntity> getUserData();
}
