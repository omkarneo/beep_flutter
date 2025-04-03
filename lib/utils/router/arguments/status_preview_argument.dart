import 'package:beep/features/dashboard/data/model/status_reponse.dart';

class StatusPreviewArgument {
  final List<Status> statusList;
  final int index;

  StatusPreviewArgument({required this.index, required this.statusList});
}
