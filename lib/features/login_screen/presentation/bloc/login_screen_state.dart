part of 'login_screen_bloc.dart';

sealed class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

final class MoblieNumberScreenState extends LoginScreenState {}

final class OtpScreenState extends LoginScreenState {
  final String number;
  const OtpScreenState({required this.number});
  @override
  List<Object> get props => [number];
}

final class SuccessState extends LoginScreenState {
  final String token;
  final bool newaccount;
  final bool isexpired;

  const SuccessState(
      {required this.token, required this.newaccount, required this.isexpired});
  @override
  List<Object> get props => [token];
}

final class ErrorState extends LoginScreenState {
  final String errmessage;
  const ErrorState({required this.errmessage});
  @override
  List<Object> get props => [errmessage];
}
