import 'package:au_chat/common/api_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider {
  IO.Socket _socket  = IO.io(APIConfig.baseURL);

  establishConnection() {
    _socket.connect();
    print(_socket);
  }

  closeConnection() {
    _socket.disconnect();
  }

  addMessage(String messBody, String userId, String channelId) {
    print('messBody $messBody');
    _socket.onConnect((_) {
      print('newMessage');
      _socket.emit("newMessage", { messBody, userId, channelId });
    });

  }

  getChatMessage() {
    _socket.on("messageCreated", (data) {
      print('data[0]data[0] data[0]');
      String messBody = data[0];
      String userId = data[1];
      String channelId = data[2];
    });
  }
}