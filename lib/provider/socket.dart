import 'package:au_chat/common/api_config.dart';
import 'package:au_chat/provider/api_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider {
  late IO.Socket socket;
  String curentUserId = APIService.userIdCurrent;

  establishConnection() {
    socket = IO.io(
        APIConfig.baseURL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setQuery({'userId': curentUserId})
            .build());

    socket.connect();
    socket.on('connect', (_) => print('Connected'));
    socket.on('disconnect', (_) => print('Disconnected'));
    // _socket.emit("newMessage", {"t1", "t2", "t3"});
    // _socket.on("messageCreated", (data) {
    //   print('${data}');
    // });
  }

  closeConnection() {
    socket.disconnect();
  }

  addMessage(String messBody, String toUserId) {
    print('messBody $messBody $toUserId');
    socket.emit("sendMessage", {'message' : messBody, 'toUserId': toUserId});
  }

  getChatMessage() {
    socket.on("addMessageResponse", (data) {
      print('$data');

      return data['message'];
    });
  }
}
