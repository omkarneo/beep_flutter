part of 'update_profile_bloc.dart';

sealed class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileDataEvent extends UpdateProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final File? photourl;
  const UpdateProfileDataEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.photourl,
  });

  @override
  List<Object> get props => [];
}
