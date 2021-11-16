import 'package:au_chat/common/enums/message_type_enum.dart';
import 'package:au_chat/common/enums/user_type_enum.dart';
import 'package:au_chat/provider/api_service.dart';

class ChatMessage {
  dynamic messageContent; //includes: iconCode(int), image path, text
  UserType userType;
  MessageType messageType;

  ChatMessage(this.messageContent,
      [this.userType = UserType.sender, this.messageType = MessageType.text]);

  factory ChatMessage.fromJson(Map<String, dynamic> data) {
    final messageContent = data["content"];
    final userType = data["userId"] == APIService.user.id
        ? UserType.sender
        : UserType.receiver;
    final messageType = MessageType.text;
    return ChatMessage(messageContent, userType, messageType);
  }
}
