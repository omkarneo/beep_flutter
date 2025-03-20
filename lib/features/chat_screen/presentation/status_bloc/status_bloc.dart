import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat_data_response_entity.dart';
import 'package:chat_app/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:chat_app/utils/helpers/socket_helper.dart';
import 'package:equatable/equatable.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final GetUserStatusUsecase getUserStatusUsecase;
  StatusBloc({required this.getUserStatusUsecase}) : super(StatusInitial()) {
    on<StartStatusSocketEvent>((event, emit) async {
      print("Status Socket Started");

      SocketHelper.socket.on("status_receviers", (data) {
        print(
            "Status Socket recived ${data["number"]} ${event.phoneNumber} ${event.phoneNumber == data["number"]}");
        if (event.phoneNumber == data['number']) {
          print("Status Socket got in new Status");
          add(ReceiverStatusEvent(id: data['number'], status: data['Status']));
        }
      });
    });
    on<GetUserStatusEvent>(
      (event, emit) async {
        ChatDataResponseEntity userData =
            await getUserStatusUsecase.call(params: event.receiverId);
        emit(StatusPageState(statusMessage: userData.receiverStatus!));
      },
    );
    on<ReceiverStatusEvent>(
      (event, emit) {
        print("Status Socket got in receiver Status");
        emit(StatusPageState(statusMessage: event.status));
      },
    );
    on<StatusDisconnect>(
      (event, emit) {
        print("Status Socket Disconnected");
        SocketHelper.socket.off("status_receviers");
        emit(StatusInitial());
      },
    );
  }
}
