class MessageModel {
  String text;
  MessageType type;
  String time;
  bool isOwnMessage;

  MessageModel({
    required this.text,
    required this.type,
    required this.time,
    required this.isOwnMessage,
  });
}

enum MessageType {
  text,
  image,
}
