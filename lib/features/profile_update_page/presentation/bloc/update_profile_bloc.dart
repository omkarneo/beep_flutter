import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:beep/features/profile_update_page/domain/entity/update_request_entity.dart';
import 'package:beep/features/profile_update_page/domain/usecase/update_usecase.dart';
import 'package:beep/shared/upload/domain/entity/profile_upload_response_entity.dart';
import 'package:beep/shared/upload/domain/usecase/profile_photo_upload_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final ProfileUpdateUseCase profileUpdateUseCase;
  final ProfilePhotoUploadUsecase profilePhotoUploadUsecase;
  UpdateProfileBloc(
      {required this.profileUpdateUseCase,
      required this.profilePhotoUploadUsecase})
      : super(UpdateProfileInitial()) {
    on<UpdateProfileDataEvent>((event, emit) async {
      try {
        String photourl = "";
        if (event.photourl != null) {
          ProfileUploadEntity response =
              await profilePhotoUploadUsecase.call(params: event.photourl);
          photourl = response.fileUrl!;
        }

        await profileUpdateUseCase.call(
            params: ProfileUpdateRequestEntity(
                email: event.email,
                firstName: event.firstName,
                lastName: event.lastName,
                photos: photourl));
        emit(UpdateProfileSuccessState());
      } catch (err) {
        emit(UpdateProfileErrorState(message: err.toString()));
      }
    });
  }
}
