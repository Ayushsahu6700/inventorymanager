import 'dart:convert';

class WarehouseModel {
  WarehouseModel({
    required this.id,
    required this.name,
    required this.managers,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.type,
    required this.users,
    required this.createdAt,
  });

  String id;
  String name;
  List<Manager> managers;
  String address;
  String city;
  String state;
  int pinCode;
  String type;
  List<dynamic> users;
  DateTime createdAt;

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => WarehouseModel(
        id: json["_id"],
        name: json["name"],
        managers: List<Manager>.from(
            json["managers"].map((x) => Manager.fromJson(x))),
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        type: json["type"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "managers": List<dynamic>.from(managers.map((x) => x.toJson())),
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "type": type,
        "users": List<dynamic>.from(users.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Manager {
  Manager({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.id,
    required this.createdAt,
    required this.managerId,
  });

  String name;
  String email;
  int phoneNo;
  String id;
  DateTime createdAt;
  String managerId;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        managerId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "id": managerId,
      };
}
