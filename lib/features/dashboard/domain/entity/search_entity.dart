import 'package:beep/features/dashboard/data/model/search_model.dart';

class SearchResponseEntity {
  String? status;
  List<UserData>? data;

  SearchResponseEntity({
    this.status,
    this.data,
  });
}
