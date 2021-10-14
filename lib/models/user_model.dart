class UserModel {
  int id;
  String username;
  String avatar;
  String status;
  String lastSeen;
  String lastMessage;
  bool isSeen;

  UserModel(this.id, this.username, this.avatar, this.status, this.lastSeen,
      this.lastMessage, this.isSeen);
}
