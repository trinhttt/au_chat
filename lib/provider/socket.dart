import 'package:au_chat/common/api_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider {
  late IO.Socket _socket;

  establishConnection() {
    _socket = IO.io(
      APIConfig.baseURL,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );
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

  addMessage(String messBody, String userId, String channelId) {
    print('messBody $messBody');
    _socket.emit("newMessage", {messBody, userId, channelId});
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
