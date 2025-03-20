part of 'status_bloc.dart';

sealed class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {
//   final String statusMessage;

//   StatusInitial({required this.statusMessage});
  @override
  List<Object> get props => [];
}

class StatusPageState extends StatusState {
  final String statusMessage;
  StatusPageState({required this.statusMessage});
  @override
  List<Object> get props => [statusMessage];
}
