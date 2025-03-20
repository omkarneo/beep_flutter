class ChatscreenArgument {
  final String name;
  final String phonenumber;
  final String? photo;
  final String roomid;
  final String receiverId;
  ChatscreenArgument(
      {required this.name,
      required this.phonenumber,
      this.photo,
      required this.roomid,
      required this.receiverId});
}
