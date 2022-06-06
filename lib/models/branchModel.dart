// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

class BranchModel {
  BranchModel({
    this.location,
    required this.id,
    required this.name,
    required this.managers,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.parentHub,
    required this.type,
    required this.users,
    required this.createdAt,
    required this.freights,
  });

  Location? location;
  String id;
  String name;
  List<Manager> managers;
  String address;
  String city;
  String state;
  int pinCode;
  String parentHub;
  String type;
  List<dynamic> users;
  DateTime createdAt;
  List<dynamic> freights;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        // location: Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        managers: List<Manager>.from(
            json["managers"].map((x) => Manager.fromJson(x))),
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        parentHub: json["parentHub"],
        type: json["type"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        freights: List<dynamic>.from(json["freights"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "location": location.toJson(),
        "_id": id,
        "name": name,
        "managers": List<dynamic>.from(managers.map((x) => x.toJson())),
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "parentHub": parentHub,
        "type": type,
        "users": List<dynamic>.from(users.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "freights": List<dynamic>.from(freights.map((x) => x)),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
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
