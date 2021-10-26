import 'package:au_chat/common/api_config.dart';
import 'package:au_chat/provider/api_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider {
  late IO.Socket _socket;
  String curentUserId = APIService.userIdCurrent;

  establishConnection() {
    _socket = IO.io(
        APIConfig.baseURL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setQuery({'userId': curentUserId})
            .build());

    _socket.connect();
    _socket.on('connect', (_) => print('Connected'));
    _socket.on('disconnect', (_) => print('Disconnected'));
    // _socket.emit("newMessage", {"t1", "t2", "t3"});
    // _socket.on("messageCreated", (data) {
    //   print('${data}');
    // });
  }

  closeConnection() {
    _socket.disconnect();
  }

  addMessage(String messBody, String toUserId) {
    print('messBody $messBody $toUserId');
    _socket.emit("sendMessage", {'message' : messBody, 'toUserId': toUserId});
  }

  getChatMessage() {
    _socket.on("messageCreated", (data) {
      // print('data[0]data[0] data[0]');
      String messBody = data[0];
      String userId = data[1];
      String channelId = data[2];
    });
  }
}
