part of 'status_upload_bloc.dart';

sealed class StatusUploadState extends Equatable {
  const StatusUploadState();

  @override
  List<Object> get props => [];
}

final class StatusUploadInitial extends StatusUploadState {}

final class StatusUploadedState extends StatusUploadState {}

final class StatusErrorState extends StatusUploadState {}
