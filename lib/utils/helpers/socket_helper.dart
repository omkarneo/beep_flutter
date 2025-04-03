import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketHelper {
  static io.Socket socket = io.io(baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });

  static init() {
    socket.connect();
    socket.onConnect((data) async {
      print("Connection established");
    });
  }

  static login(phonenumber) {
    socket.emit("login", phonenumber);
  }

  static loginWithid(id) {
    socket.emit("login_with_Id", id);
  }

  static logout(phonenumber) {
    socket.emit("logout", phonenumber);
    // socket.disconnect();
  }

  static disconnect() {
    socket.disconnect();
  }
}
