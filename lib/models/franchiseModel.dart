import 'dart:convert';

class FranchiseModel {
  FranchiseModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhoneNo,
    required this.managerName,
    required this.managerEmail,
    required this.managerPhoneNo,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.gstNo,
    required this.type,
    required this.servicablePincodes,
  });

  String id;
  String name;
  String ownerName;
  String ownerEmail;
  int ownerPhoneNo;
  String managerName;
  String managerEmail;
  int managerPhoneNo;
  String address;
  String city;
  String state;
  int pinCode;
  String gstNo;
  String type;
  List<int> servicablePincodes;

  factory FranchiseModel.fromJson(Map<String, dynamic> json) => FranchiseModel(
        id: json["_id"],
        name: json["name"],
        ownerName: json["ownerName"],
        ownerEmail: json["ownerEmail"],
        ownerPhoneNo: json["ownerPhoneNo"],
        managerName: json["managerName"],
        managerEmail: json["managerEmail"],
        managerPhoneNo: json["managerPhoneNo"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        gstNo: json["gstNo"],
        type: json["type"],
        servicablePincodes:
            List<int>.from(json["servicablePincodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ownerName": ownerName,
        "ownerEmail": ownerEmail,
        "ownerPhoneNo": ownerPhoneNo,
        "managerName": managerName,
        "managerEmail": managerEmail,
        "managerPhoneNo": managerPhoneNo,
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "gstNo": gstNo,
        "type": type,
        "servicablePincodes":
            List<dynamic>.from(servicablePincodes.map((x) => x)),
      };
}
