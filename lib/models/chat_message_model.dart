import 'package:au_chat/common/enums/message_type_enum.dart';
import 'package:au_chat/common/enums/user_type_enum.dart';

class ChatMessage {
  dynamic messageContent; //includes: iconCode(int), image path, text
  UserType userType;
  MessageType messageType;

  ChatMessage(this.messageContent,
      [this.userType = UserType.sender, this.messageType = MessageType.text]);
}
