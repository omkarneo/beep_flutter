part of 'status_upload_bloc.dart';

sealed class StatusUploadEvent extends Equatable {
  const StatusUploadEvent();

  @override
  List<Object> get props => [];
}

class UploadStatusServerEvent extends StatusUploadEvent {
  final XFile? image;
  final String? stausMessage;
  const UploadStatusServerEvent({this.image, this.stausMessage});
}

class StatusResetEvent extends StatusUploadEvent {}
