import 'package:intl/intl.dart';

class NotificationDTO {
  final int pushNotificationId;
  final int senderId;
  final String receiverId;
  final String title;
  final String body;
  final String messageType;
  final bool isRead;
  final String sender;
  final String receiver;
  final String created;
  final String lastModified;

  NotificationDTO._({
    this.pushNotificationId,
    this.senderId,
    this.receiverId,
    this.title,
    this.body,
    this.messageType,
    this.isRead,
    this.sender,
    this.receiver,
    this.created,
    this.lastModified,
  });
  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return new NotificationDTO._(
      pushNotificationId: json['pushNotificationId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      receiverId: json['receiverId'] ?? "",
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      messageType: json['messageType'] ?? "",
      isRead: json['isRead'] ?? true,
      sender: json['sender'] ?? "",
      receiver: json['receiver'] ?? "",
      created: convertTimeToLocal(json['created'] ?? '2021-05-01T08:05:00'),
      lastModified:
          convertTimeToLocal(json['lastModified'] ?? '2021-05-01T08:05:00'),
    );
  }
}

String convertTimeToLocal(String time) {
  try {
    DateTime tmpDate =
        DateFormat("yyyy-MM-ddThh:mm:ss").parse(time, true).toLocal();
    return tmpDate.toString().split(".").first;
  } catch (e) {
    print("Error when convert time" + e);
  }
  return '';
}
