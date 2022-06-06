// To parse this JSON data, do
//
//     final outwardingPackageModel = outwardingPackageModelFromJson(jsonString);

import 'dart:convert';

class OutwardingPackageModel {
  OutwardingPackageModel(
      {this.dimensions,
      this.sourceAddress,
      this.deliveryAddress,
      this.id,
      this.packageId,
      this.name,
      this.phoneNo,
      this.secureShipment,
      this.insurance,
      this.isDocument,
      this.inPersonDelivery,
      this.planType,
      this.pop,
      this.pod,
      this.packagingService,
      this.verifiedByInventoryManager,
      this.packageDispute,
      this.weight,
      this.valueOfGoods,
      this.status,
      this.trackingStatus,
      this.receiverName,
      this.receiverPhoneNo,
      this.onHold,
      this.sourceBranchId,
      this.inTransit,
      this.internalTransit,
      this.inwardedBySourceFranchise,
      this.inwardedBySourceDistributor,
      this.inwardedBySourceBranch,
      this.inwardedBySourceHub,
      this.inwardedBySourceWarehouse,
      this.inwardedBySourceParentWarehouse,
      this.inwardedByDestinationFranchise,
      this.inwardedByDestinationDistributor,
      this.inwardedByDestinationBranch,
      this.inwardedByDestinationHub,
      this.inwardedByDestinationWarehouse,
      this.inwardedByDestinationParentWarehouse,
      this.delivered,
      this.createdByType,
      this.createdById,
      this.dateOfBooking,
      this.v,
      this.isFinalStation
      //  this.sourceDistributor,
      // this.sourceBranch,
      // this.outwardingPackageModelId,
      });

  Dimensions? dimensions;
  Address? sourceAddress;
  Address? deliveryAddress;
  String? id;
  String? packageId;
  String? name;
  int? phoneNo;
  bool? secureShipment;
  bool? insurance;
  bool? isDocument;
  bool? inPersonDelivery;
  String? planType;
  bool? pop;
  bool? pod;
  bool? packagingService;
  bool? verifiedByInventoryManager;
  bool? packageDispute;
  int? weight;
  int? valueOfGoods;
  String? status;
  List<TrackingStatus>? trackingStatus;
  String? receiverName;
  int? receiverPhoneNo;
  bool? onHold;
  String? sourceBranchId;
  bool? inTransit;
  bool? internalTransit;
  bool? inwardedBySourceFranchise;
  bool? inwardedBySourceDistributor;
  bool? inwardedBySourceBranch;
  bool? inwardedBySourceHub;
  bool? inwardedBySourceWarehouse;
  bool? inwardedBySourceParentWarehouse;
  bool? inwardedByDestinationFranchise;
  bool? inwardedByDestinationDistributor;
  bool? inwardedByDestinationBranch;
  bool? inwardedByDestinationHub;
  bool? inwardedByDestinationWarehouse;
  bool? inwardedByDestinationParentWarehouse;
  bool? delivered;
  String? createdByType;
  String? createdById;
  DateTime? dateOfBooking;
  int? v;
  bool? isFinalStation;
  // dynamic sourceDistributor;
  // SourceBranch sourceBranch;
  // String outwardingPackageModelId;

  factory OutwardingPackageModel.fromJson(Map<String, dynamic> json) =>
      OutwardingPackageModel(
        dimensions: Dimensions.fromJson(json["dimensions"]),
        sourceAddress: Address.fromJson(json["sourceAddress"]),
        deliveryAddress: Address.fromJson(json["deliveryAddress"]),
        id: json["_id"],
        packageId: json["packageId"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        secureShipment: json["secureShipment"],
        insurance: json["insurance"],
        isDocument: json["isDocument"],
        inPersonDelivery: json["inPersonDelivery"],
        planType: json["planType"],
        pop: json["pop"],
        pod: json["pod"],
        packagingService: json["packagingService"],
        verifiedByInventoryManager: json["verifiedByInventoryManager"],
        packageDispute: json["packageDispute"],
        weight: json["weight"],
        valueOfGoods: json["valueOfGoods"],
        status: json["status"],
        trackingStatus: List<TrackingStatus>.from(
            json["trackingStatus"].map((x) => TrackingStatus.fromJson(x))),
        receiverName: json["receiverName"],
        receiverPhoneNo: json["receiverPhoneNo"],
        onHold: json["onHold"],
        sourceBranchId: json["sourceBranchId"],
        inTransit: json["inTransit"],
        internalTransit: json["internalTransit"],
        inwardedBySourceFranchise: json["inwardedBySourceFranchise"],
        inwardedBySourceDistributor: json["inwardedBySourceDistributor"],
        inwardedBySourceBranch: json["inwardedBySourceBranch"],
        inwardedBySourceHub: json["inwardedBySourceHub"],
        inwardedBySourceWarehouse: json["inwardedBySourceWarehouse"],
        inwardedBySourceParentWarehouse:
            json["inwardedBySourceParentWarehouse"],
        inwardedByDestinationFranchise: json["inwardedByDestinationFranchise"],
        inwardedByDestinationDistributor:
            json["inwardedByDestinationDistributor"],
        inwardedByDestinationBranch: json["inwardedByDestinationBranch"],
        inwardedByDestinationHub: json["inwardedByDestinationHub"],
        inwardedByDestinationWarehouse: json["inwardedByDestinationWarehouse"],
        inwardedByDestinationParentWarehouse:
            json["inwardedByDestinationParentWarehouse"],
        delivered: json["delivered"],
        createdByType: json["createdByType"],
        createdById: json["createdById"],
        dateOfBooking: DateTime.parse(json["dateOfBooking"]),
        v: json["__v"],
        isFinalStation: json["isFinalStation"],
        // sourceDistributor: json["sourceDistributor"],
        // sourceBranch: SourceBranch.fromJson(json["sourceBranch"]),
        // outwardingPackageModelId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions?.toJson(),
        "sourceAddress": sourceAddress?.toJson(),
        "deliveryAddress": deliveryAddress?.toJson(),
        "_id": id,
        "packageId": packageId,
        "name": name,
        "phoneNo": phoneNo,
        "secureShipment": secureShipment,
        "insurance": insurance,
        "isDocument": isDocument,
        "inPersonDelivery": inPersonDelivery,
        "planType": planType,
        "pop": pop,
        "pod": pod,
        "packagingService": packagingService,
        "verifiedByInventoryManager": verifiedByInventoryManager,
        "packageDispute": packageDispute,
        "weight": weight,
        "valueOfGoods": valueOfGoods,
        "status": status,
        "trackingStatus":
            List<dynamic>.from(trackingStatus!.map((x) => x.toJson())),
        "receiverName": receiverName,
        "receiverPhoneNo": receiverPhoneNo,
        "onHold": onHold,
        "sourceBranchId": sourceBranchId,
        "inTransit": inTransit,
        "internalTransit": internalTransit,
        "inwardedBySourceFranchise": inwardedBySourceFranchise,
        "inwardedBySourceDistributor": inwardedBySourceDistributor,
        "inwardedBySourceBranch": inwardedBySourceBranch,
        "inwardedBySourceHub": inwardedBySourceHub,
        "inwardedBySourceWarehouse": inwardedBySourceWarehouse,
        "inwardedBySourceParentWarehouse": inwardedBySourceParentWarehouse,
        "inwardedByDestinationFranchise": inwardedByDestinationFranchise,
        "inwardedByDestinationDistributor": inwardedByDestinationDistributor,
        "inwardedByDestinationBranch": inwardedByDestinationBranch,
        "inwardedByDestinationHub": inwardedByDestinationHub,
        "inwardedByDestinationWarehouse": inwardedByDestinationWarehouse,
        "inwardedByDestinationParentWarehouse":
            inwardedByDestinationParentWarehouse,
        "delivered": delivered,
        "createdByType": createdByType,
        "createdById": createdById,
        "dateOfBooking": dateOfBooking?.toIso8601String(),
        "__v": v,
        "isFinalStation": isFinalStation,
        // "sourceDistributor": sourceDistributor,
        // "sourceBranch": sourceBranch.toJson(),
        // "id": outwardingPackageModelId,
      };
}

class Address {
  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
  });

  String address;
  String city;
  String state;
  int pinCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
      };
}

class Dimensions {
  Dimensions({
    required this.width,
    required this.height,
    required this.length,
  });

  int width;
  int height;
  int length;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"],
        height: json["height"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "length": length,
      };
}

class SourceBranch {
  SourceBranch({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory SourceBranch.fromJson(Map<String, dynamic> json) => SourceBranch(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class TrackingStatus {
  TrackingStatus({
    required this.title,
    required this.desc,
    required this.date,
    required this.location,
    required this.userType,
    required this.userId,
    required this.id,
  });

  String title;
  String desc;
  DateTime date;
  String location;
  String userType;
  String userId;
  String id;

  factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
        title: json["title"],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        location: json["location"],
        userType: json["userType"],
        userId: json["userId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "date": date.toIso8601String(),
        "location": location,
        "userType": userType,
        "userId": userId,
        "_id": id,
      };
}
