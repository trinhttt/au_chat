class UserModel {
  String id;
  String username;
  String avatar;
  String status;
  String lastSeen;
  String lastMessage;
  bool isSeen;
  String socketId;

  UserModel(this.id, this.username, this.avatar, this.status, this.lastSeen,
      this.lastMessage, this.isSeen, this.socketId);
}
