// import 'dart:convert';
//
// class InwardingPackagesModel {
//   InwardingPackagesModel({
//     required this.dimensions,
//     required this.sourceAddress,
//     required this.deliveryAddress,
//     required this.onHold,
//     required this.id,
//     required this.packageId,
//     required this.name,
//     required this.phoneNo,
//     required this.secureShipment,
//     required this.insurance,
//     required this.isDocument,
//     required this.inPersonDelivery,
//     required this.planType,
//     required this.pop,
//     required this.pod,
//     required this.packagingService,
//     required this.weight,
//     required this.valueOfGoods,
//     required this.status,
//     required this.trackingStatus,
//     required this.receiverName,
//     required this.receiverPhoneNo,
//     required this.retailerId,
//     required this.inTransit,
//     required this.internalTransit,
//     required this.inwardedBySourceFranchise,
//     required this.inwardedBySourceDistributor,
//     required this.inwardedBySourceBranch,
//     required this.inwardedBySourceHub,
//     required this.inwardedBySourceWarehouse,
//     required this.inwardedBySourceParentWarehouse,
//     required this.inwardedByDestinationFranchise,
//     required this.inwardedByDestinationDistributor,
//     required this.inwardedByDestinationBranch,
//     required this.inwardedByDestinationHub,
//     required this.inwardedByDestinationWarehouse,
//     required this.inwardedByDestinationParentWarehouse,
//     required this.createdByType,
//     required this.createdById,
//     required this.dateOfBooking,
//     required this.v,
//     required this.delivered,
//     required this.deliveredAt,
//     required this.inwardingPackagesId,
//   });
//
//   Dimensions dimensions;
//   Address sourceAddress;
//   Address deliveryAddress;
//   bool onHold;
//   String id;
//   String packageId;
//   String name;
//   int phoneNo;
//   bool secureShipment;
//   bool insurance;
//   bool isDocument;
//   bool inPersonDelivery;
//   String planType;
//   bool pop;
//   bool pod;
//   bool packagingService;
//   int weight;
//   int valueOfGoods;
//   String status;
//   List<TrackingStatus> trackingStatus;
//   String receiverName;
//   int receiverPhoneNo;
//   String retailerId;
//   bool inTransit;
//   bool internalTransit;
//   bool inwardedBySourceFranchise;
//   bool inwardedBySourceDistributor;
//   bool inwardedBySourceBranch;
//   bool inwardedBySourceHub;
//   bool inwardedBySourceWarehouse;
//   bool inwardedBySourceParentWarehouse;
//   bool inwardedByDestinationFranchise;
//   bool inwardedByDestinationDistributor;
//   bool inwardedByDestinationBranch;
//   bool inwardedByDestinationHub;
//   bool inwardedByDestinationWarehouse;
//   bool inwardedByDestinationParentWarehouse;
//   String createdByType;
//   String createdById;
//   DateTime dateOfBooking;
//   int v;
//   bool delivered;
//   dynamic deliveredAt;
//   String inwardingPackagesId;
//
//   factory InwardingPackagesModel.fromJson(Map<String, dynamic> json) =>
//       InwardingPackagesModel(
//         dimensions: Dimensions.fromJson(json["dimensions"]),
//         sourceAddress: Address.fromJson(json["sourceAddress"]),
//         deliveryAddress: Address.fromJson(json["deliveryAddress"]),
//         onHold: json["onHold"],
//         id: json["_id"],
//         packageId: json["packageId"],
//         name: json["name"],
//         phoneNo: json["phoneNo"],
//         secureShipment: json["secureShipment"],
//         insurance: json["insurance"],
//         isDocument: json["isDocument"],
//         inPersonDelivery: json["inPersonDelivery"],
//         planType: json["planType"],
//         pop: json["pop"],
//         pod: json["pod"],
//         packagingService: json["packagingService"],
//         weight: json["weight"],
//         valueOfGoods: json["valueOfGoods"],
//         status: json["status"],
//         trackingStatus: List<TrackingStatus>.from(
//             json["trackingStatus"].map((x) => TrackingStatus.fromJson(x))),
//         receiverName: json["receiverName"],
//         receiverPhoneNo: json["receiverPhoneNo"],
//         retailerId: json["retailerId"],
//         inTransit: json["inTransit"],
//         internalTransit: json["internalTransit"],
//         inwardedBySourceFranchise: json["inwardedBySourceFranchise"],
//         inwardedBySourceDistributor: json["inwardedBySourceDistributor"],
//         inwardedBySourceBranch: json["inwardedBySourceBranch"],
//         inwardedBySourceHub: json["inwardedBySourceHub"],
//         inwardedBySourceWarehouse: json["inwardedBySourceWarehouse"],
//         inwardedBySourceParentWarehouse:
//             json["inwardedBySourceParentWarehouse"],
//         inwardedByDestinationFranchise: json["inwardedByDestinationFranchise"],
//         inwardedByDestinationDistributor:
//             json["inwardedByDestinationDistributor"],
//         inwardedByDestinationBranch: json["inwardedByDestinationBranch"],
//         inwardedByDestinationHub: json["inwardedByDestinationHub"],
//         inwardedByDestinationWarehouse: json["inwardedByDestinationWarehouse"],
//         inwardedByDestinationParentWarehouse:
//             json["inwardedByDestinationParentWarehouse"],
//         createdByType: json["createdByType"],
//         createdById: json["createdById"],
//         dateOfBooking: DateTime.parse(json["dateOfBooking"]),
//         v: json["__v"],
//         delivered: json["delivered"],
//         deliveredAt: json["deliveredAt"],
//         inwardingPackagesId: json["id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "dimensions": dimensions.toJson(),
//         "sourceAddress": sourceAddress.toJson(),
//         "deliveryAddress": deliveryAddress.toJson(),
//         "onHold": onHold,
//         "_id": id,
//         "packageId": packageId,
//         "name": name,
//         "phoneNo": phoneNo,
//         "secureShipment": secureShipment,
//         "insurance": insurance,
//         "isDocument": isDocument,
//         "inPersonDelivery": inPersonDelivery,
//         "planType": planType,
//         "pop": pop,
//         "pod": pod,
//         "packagingService": packagingService,
//         "weight": weight,
//         "valueOfGoods": valueOfGoods,
//         "status": status,
//         "trackingStatus":
//             List<dynamic>.from(trackingStatus.map((x) => x.toJson())),
//         "receiverName": receiverName,
//         "receiverPhoneNo": receiverPhoneNo,
//         "retailerId": retailerId,
//         "inTransit": inTransit,
//         "internalTransit": internalTransit,
//         "inwardedBySourceFranchise": inwardedBySourceFranchise,
//         "inwardedBySourceDistributor": inwardedBySourceDistributor,
//         "inwardedBySourceBranch": inwardedBySourceBranch,
//         "inwardedBySourceHub": inwardedBySourceHub,
//         "inwardedBySourceWarehouse": inwardedBySourceWarehouse,
//         "inwardedBySourceParentWarehouse": inwardedBySourceParentWarehouse,
//         "inwardedByDestinationFranchise": inwardedByDestinationFranchise,
//         "inwardedByDestinationDistributor": inwardedByDestinationDistributor,
//         "inwardedByDestinationBranch": inwardedByDestinationBranch,
//         "inwardedByDestinationHub": inwardedByDestinationHub,
//         "inwardedByDestinationWarehouse": inwardedByDestinationWarehouse,
//         "inwardedByDestinationParentWarehouse":
//             inwardedByDestinationParentWarehouse,
//         "createdByType": createdByType,
//         "createdById": createdById,
//         "dateOfBooking": dateOfBooking.toIso8601String(),
//         "__v": v,
//         "delivered": delivered,
//         "deliveredAt": deliveredAt,
//         "id": inwardingPackagesId,
//       };
// }
//
// class Address {
//   Address({
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.pinCode,
//   });
//
//   String address;
//   String city;
//   String state;
//   int pinCode;
//
//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         pinCode: json["pinCode"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "address": address,
//         "city": city,
//         "state": state,
//         "pinCode": pinCode,
//       };
// }
//
// class Dimensions {
//   Dimensions({
//     required this.width,
//     required this.height,
//     required this.length,
//   });
//
//   int width;
//   int height;
//   int length;
//
//   factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
//         width: json["width"],
//         height: json["height"],
//         length: json["length"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "width": width,
//         "height": height,
//         "length": length,
//       };
// }
//
// class TrackingStatus {
//   TrackingStatus({
//     required this.title,
//     required this.desc,
//     required this.date,
//     required this.location,
//     required this.userType,
//     required this.userId,
//     required this.id,
//   });
//
//   String title;
//   String desc;
//   DateTime date;
//   String location;
//   String userType;
//   String userId;
//   String id;
//
//   factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
//         title: json["title"],
//         desc: json["desc"],
//         date: DateTime.parse(json["date"]),
//         location: json["location"],
//         userType: json["userType"],
//         userId: json["userId"],
//         id: json["_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "desc": desc,
//         "date": date.toIso8601String(),
//         "location": location,
//         "userType": userType,
//         "userId": userId,
//         "_id": id,
//       };
// }
// To parse this JSON data, do
//
//     final inwardingPackagesModel = inwardingPackagesModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final inwardingPackagesModel = inwardingPackagesModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final inwardingPackagesModel = inwardingPackagesModelFromJson(jsonString);

import 'dart:convert';

class InwardingPackagesModel {
  InwardingPackagesModel({
    // this.verifiedData,
    this.dimensions,
    this.sourceAddress,
    this.deliveryAddress,
    this.id,
    this.packageId,
    this.name,
    this.phoneNo,
    this.userId,
    this.pickupId,
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
    this.status,
    this.trackingStatus,
    this.receiverName,
    this.isFinalStation,
    this.receiverPhoneNo,
    this.onHold,
    this.sourceFranchiseId,
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
    this.sourceBranchId,
    this.inwardingPackagesModelId,
  });

  // VerifiedData? verifiedData;
  Dimensions? dimensions;
  Address? sourceAddress;
  Address? deliveryAddress;
  String? id;
  String? packageId;
  String? name;
  int? phoneNo;
  String? userId;
  String? pickupId;
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
  String? status;
  List<TrackingStatus>? trackingStatus;
  String? receiverName;
  bool? isFinalStation;
  int? receiverPhoneNo;
  bool? onHold;
  String? sourceFranchiseId;
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

  String? sourceBranchId;
  String? inwardingPackagesModelId;

  factory InwardingPackagesModel.fromJson(Map<String, dynamic> json) =>
      InwardingPackagesModel(
        // verifiedData: VerifiedData.fromJson(json["verifiedData"]),
        dimensions: Dimensions.fromJson(json["dimensions"]),
        sourceAddress: Address.fromJson(json["sourceAddress"]),
        deliveryAddress: Address.fromJson(json["deliveryAddress"]),
        id: json["_id"],
        packageId: json["packageId"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        userId: json["userId"],
        pickupId: json["pickupId"],
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
        status: json["status"],
        trackingStatus: List<TrackingStatus>.from(
            json["trackingStatus"].map((x) => TrackingStatus.fromJson(x))),
        receiverName: json["receiverName"],
        isFinalStation: json["isFinalStation"],
        receiverPhoneNo: json["receiverPhoneNo"],
        onHold: json["onHold"],
        sourceFranchiseId: json["sourceFranchiseId"],
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
        sourceBranchId: json["sourceBranchId"],
        inwardingPackagesModelId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        // "verifiedData": verifiedData?.toJson(),
        "dimensions": dimensions?.toJson(),
        "sourceAddress": sourceAddress?.toJson(),
        "deliveryAddress": deliveryAddress?.toJson(),
        "_id": id,
        "packageId": packageId,
        "name": name,
        "phoneNo": phoneNo,
        "userId": userId,
        "pickupId": pickupId,
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
        "status": status,
        "trackingStatus":
            List<dynamic>.from(trackingStatus!.map((x) => x.toJson())),
        "receiverName": receiverName,
        "isFinalStation": isFinalStation,
        "receiverPhoneNo": receiverPhoneNo,
        "onHold": onHold,
        "sourceFranchiseId": sourceFranchiseId,
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
        "sourceBranchId": sourceBranchId,
        "id": inwardingPackagesModelId,
      };
}

class Address {
  Address({
    this.address,
    this.city,
    this.state,
    this.pinCode,
  });

  String? address;
  String? city;
  String? state;
  int? pinCode;

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
    this.width,
    this.height,
    this.length,
  });

  int? width;
  int? height;
  int? length;

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

class TrackingStatus {
  TrackingStatus({
    this.title,
    this.desc,
    this.date,
    this.location,
    this.userType,
    this.userId,
    this.id,
  });

  String? title;
  String? desc;
  DateTime? date;
  String? location;
  String? userType;
  String? userId;
  String? id;

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
        "date": date?.toIso8601String(),
        "location": location,
        "userType": userType,
        "userId": userId,
        "_id": id,
      };
}

class VerifiedData {
  VerifiedData({
    this.dimensions,
    this.weight,
  });

  Dimensions? dimensions;
  int? weight;

  factory VerifiedData.fromJson(Map<String, dynamic> json) => VerifiedData(
        dimensions: Dimensions.fromJson(json["dimensions"]),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions?.toJson(),
        "weight": weight,
      };
}
