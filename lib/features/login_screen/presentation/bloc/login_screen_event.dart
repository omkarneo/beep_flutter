part of 'login_screen_bloc.dart';

sealed class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();
  @override
  List<Object> get props => [];
}

class ResetEvent extends LoginScreenEvent {
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class EntryEvent extends LoginScreenEvent {
  final String number;

  const EntryEvent({required this.number});

  @override
  List<Object> get props => [number];
}

class OtpEvent extends LoginScreenEvent {
  final String number;
  final String otp;

  const OtpEvent({required this.otp, required this.number});
  @override
  List<Object> get props => [otp, number];
}
