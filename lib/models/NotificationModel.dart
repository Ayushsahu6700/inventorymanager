class NotificationsModel {
  NotificationsModel({
    this.id,
    this.title,
    this.text,
    this.userId,
    this.read,
    this.messageId,
    this.parentId,
    this.parentType,
    this.createdAt,
    this.v,
    this.readAt,
  });

  String? id;
  String? title;
  String? text;
  String? userId;
  bool? read;
  String? messageId;
  String? parentId;
  String? parentType;
  DateTime? createdAt;
  int? v;
  DateTime? readAt;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        userId: json["userId"] == null ? null : json["userId"],
        read: json["read"] == null ? null : json["read"],
        messageId: json["messageId"] == null ? null : json["messageId"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        parentType: json["parentType"] == null ? null : json["parentType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"] == null ? null : json["__v"],
        readAt: json["readAt"] == null ? null : DateTime.parse(json["readAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "userId": userId == null ? null : userId,
        "read": read == null ? null : read,
        "messageId": messageId == null ? null : messageId,
        "parentId": parentId == null ? null : parentId,
        "parentType": parentType == null ? null : parentType,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "__v": v == null ? null : v,
        "readAt": readAt == null ? null : readAt?.toIso8601String(),
      };
}
