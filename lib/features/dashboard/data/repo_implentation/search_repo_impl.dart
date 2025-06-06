import 'package:beep/features/dashboard/data/datasource/search_ds.dart';
import 'package:beep/features/dashboard/domain/entity/search_entity.dart';
import 'package:beep/features/dashboard/domain/repo/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchDataSource searchDataSource;
  SearchRepoImpl({required this.searchDataSource});
  @override
  Future<SearchResponseEntity> getUserData() async {
    var data = await searchDataSource.searchApiCall();
    return SearchResponseEntity(data: data.data, status: data.status);
  }
}
