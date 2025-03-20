part of 'update_profile_bloc.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileSuccessState extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileErrorState extends UpdateProfileState {
  final String message;
  const UpdateProfileErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
