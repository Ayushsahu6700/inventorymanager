// To parse this JSON data, do
//
//     final retailerModel = retailerModelFromJson(jsonString);

import 'dart:convert';

class RetailerModel {
  RetailerModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhoneNo,
    required this.type,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.aadharCardDocumentId,
    required this.contractDocumentId,
    required this.v,
  });

  String id;
  String name;
  String ownerName;
  String ownerEmail;
  int ownerPhoneNo;
  String type;
  String address;
  String city;
  String state;
  int pinCode;
  String aadharCardDocumentId;
  String contractDocumentId;
  int v;

  factory RetailerModel.fromJson(Map<String, dynamic> json) => RetailerModel(
        id: json["_id"],
        name: json["name"],
        ownerName: json["ownerName"],
        ownerEmail: json["ownerEmail"],
        ownerPhoneNo: json["ownerPhoneNo"],
        type: json["type"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        aadharCardDocumentId: json["aadharCardDocumentId"],
        contractDocumentId: json["contractDocumentId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ownerName": ownerName,
        "ownerEmail": ownerEmail,
        "ownerPhoneNo": ownerPhoneNo,
        "type": type,
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "aadharCardDocumentId": aadharCardDocumentId,
        "contractDocumentId": contractDocumentId,
        "__v": v,
      };
}
