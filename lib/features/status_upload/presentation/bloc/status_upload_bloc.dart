import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:beep/features/status_upload/domain/entity/add_status_request_entity.dart';
import 'package:beep/features/status_upload/domain/usecase/status_create_usecase.dart';
import 'package:beep/features/status_upload/domain/usecase/status_upload_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'status_upload_event.dart';
part 'status_upload_state.dart';

class StatusUploadBloc extends Bloc<StatusUploadEvent, StatusUploadState> {
  final StatusCreateUsecase statusCreateUsecase;
  final StatusUploadUsecase statusUploadUsecase;
  StatusUploadBloc(
      {required this.statusCreateUsecase, required this.statusUploadUsecase})
      : super(StatusUploadInitial()) {
    on<StatusResetEvent>(
      (event, emit) {
        emit(StatusUploadInitial());
      },
    );
    on<UploadStatusServerEvent>((event, emit) async {
      try {
        if (event.image != null) {
          var statusupload =
              await statusUploadUsecase.call(params: File(event.image!.path));

          await statusCreateUsecase.call(
              params: StatusAddRequestEntity(
                  statusImage: statusupload.fileUrl,
                  statusType: "Image",
                  stausMessage: event.stausMessage));
        } else {
          await statusCreateUsecase.call(
              params: StatusAddRequestEntity(
                  statusType: "Text", stausMessage: event.stausMessage));
        }
        emit(StatusUploadedState());
      } catch (err) {
        print(err);
        emit(StatusErrorState());
      }
    });
  }
}
