// To parse this JSON data, do
//
//     final distributerModel = distributerModelFromJson(jsonString);

import 'dart:convert';

class DistributerModel {
  DistributerModel({
    required this.id,
    required this.name,
    required this.commission,
    required this.location,
    required this.managers,
    required this.owners,
    required this.status,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.gstNo,
    required this.type,
    required this.aadharCardDocumentId,
    required this.contractDocumentId,
    required this.createdByType,
    required this.createdById,
    required this.parentBranch,
    required this.users,
    required this.freights,
    required this.charges,
    required this.createdAt,
    required this.servicablePincodes,
  });

  String id;
  String name;
  int commission;
  Location location;
  List<Manager> managers;
  List<Manager> owners;
  String status;
  String address;
  String city;
  String state;
  int pinCode;
  String gstNo;
  String type;
  String aadharCardDocumentId;
  String contractDocumentId;
  String createdByType;
  String createdById;
  String parentBranch;
  List<dynamic> users;
  List<Freight> freights;
  List<dynamic> charges;
  DateTime createdAt;
  List<int> servicablePincodes;

  factory DistributerModel.fromJson(Map<String, dynamic> json) =>
      DistributerModel(
        id: json["_id"],
        name: json["name"],
        commission: json["commission"],
        location: Location.fromJson(json["location"]),
        managers: List<Manager>.from(
            json["managers"].map((x) => Manager.fromJson(x))),
        owners:
            List<Manager>.from(json["owners"].map((x) => Manager.fromJson(x))),
        status: json["status"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        gstNo: json["gstNo"],
        type: json["type"],
        aadharCardDocumentId: json["aadharCardDocumentId"],
        contractDocumentId: json["contractDocumentId"],
        createdByType: json["createdByType"],
        createdById: json["createdById"],
        parentBranch: json["parentBranch"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
        freights: List<Freight>.from(
            json["freights"].map((x) => Freight.fromJson(x))),
        charges: List<dynamic>.from(json["charges"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        servicablePincodes:
            List<int>.from(json["servicablePincodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "commission": commission,
        "location": location.toJson(),
        "managers": List<dynamic>.from(managers.map((x) => x.toJson())),
        "owners": List<dynamic>.from(owners.map((x) => x.toJson())),
        "status": status,
        "address": address,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "gstNo": gstNo,
        "type": type,
        "aadharCardDocumentId": aadharCardDocumentId,
        "contractDocumentId": contractDocumentId,
        "createdByType": createdByType,
        "createdById": createdById,
        "parentBranch": parentBranch,
        "users": List<dynamic>.from(users.map((x) => x)),
        "freights": List<dynamic>.from(freights.map((x) => x.toJson())),
        "charges": List<dynamic>.from(charges.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "servicablePincodes":
            List<dynamic>.from(servicablePincodes.map((x) => x)),
      };
}

class Freight {
  Freight({
    required this.fromCity,
    required this.fromState,
    required this.fromPincode,
    required this.toCity,
    required this.toState,
    required this.toPincode,
    required this.charges,
    required this.createdAt,
    required this.id,
  });

  String fromCity;
  String fromState;
  int fromPincode;
  String toCity;
  String toState;
  int toPincode;
  List<Charge> charges;
  DateTime createdAt;
  String id;

  factory Freight.fromJson(Map<String, dynamic> json) => Freight(
        fromCity: json["fromCity"],
        fromState: json["fromState"],
        fromPincode: json["fromPincode"],
        toCity: json["toCity"],
        toState: json["toState"],
        toPincode: json["toPincode"],
        charges:
            List<Charge>.from(json["charges"].map((x) => Charge.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "fromCity": fromCity,
        "fromState": fromState,
        "fromPincode": fromPincode,
        "toCity": toCity,
        "toState": toState,
        "toPincode": toPincode,
        "charges": List<dynamic>.from(charges.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "_id": id,
      };
}

class Charge {
  Charge({
    required this.docketChargeCosts,
    required this.weightChargeCosts,
    required this.fovValue,
    required this.minWeightDocket,
    required this.minWeightPerBox,
    required this.fuelCharge,
    required this.gst,
    required this.maxLiabilityDocket,
    required this.remoteOtaPickupCharge,
    required this.remoteOtaDeliveryCharge,
    required this.packagingCostPerBox,
    required this.codChargePerDocket,
    required this.codChargePerBox,
    required this.deliveryHaltChargeDay1,
    required this.deliveryHaltChargeDay2,
    required this.deliveryHaltChargeDay3,
    required this.deliveryHaltChargeDay4,
    required this.haltChargeLoadingPoint,
    required this.vehicleCharge,
    required this.misc1,
    required this.minChargableWeight,
    required this.perCftCost,
    required this.minChargableCft,
    required this.minGrAmount,
    required this.lateDeliveryCharges,
    required this.coMinLiability,
    required this.coMaxLiability,
    required this.fsc,
    required this.productRestrictionPenalization,
    required this.mode,
    required this.id,
    required this.createdAt,
  });

  List<TChargeCost> docketChargeCosts;
  List<TChargeCost> weightChargeCosts;
  int fovValue;
  int minWeightDocket;
  int minWeightPerBox;
  int fuelCharge;
  int gst;
  int maxLiabilityDocket;
  int remoteOtaPickupCharge;
  int remoteOtaDeliveryCharge;
  int packagingCostPerBox;
  int codChargePerDocket;
  int codChargePerBox;
  int deliveryHaltChargeDay1;
  int deliveryHaltChargeDay2;
  int deliveryHaltChargeDay3;
  int deliveryHaltChargeDay4;
  int haltChargeLoadingPoint;
  int vehicleCharge;
  int misc1;
  int minChargableWeight;
  int perCftCost;
  int minChargableCft;
  int minGrAmount;
  int lateDeliveryCharges;
  int coMinLiability;
  int coMaxLiability;
  int fsc;
  int productRestrictionPenalization;
  String mode;
  String id;
  DateTime createdAt;

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        docketChargeCosts: List<TChargeCost>.from(
            json["docketChargeCosts"].map((x) => TChargeCost.fromJson(x))),
        weightChargeCosts: List<TChargeCost>.from(
            json["weightChargeCosts"].map((x) => TChargeCost.fromJson(x))),
        fovValue: json["fovValue"],
        minWeightDocket: json["minWeightDocket"],
        minWeightPerBox: json["minWeightPerBox"],
        fuelCharge: json["fuelCharge"],
        gst: json["gst"],
        maxLiabilityDocket: json["maxLiabilityDocket"],
        remoteOtaPickupCharge: json["remoteOTAPickupCharge"],
        remoteOtaDeliveryCharge: json["remoteOTADeliveryCharge"],
        packagingCostPerBox: json["packagingCostPerBox"],
        codChargePerDocket: json["codChargePerDocket"],
        codChargePerBox: json["codChargePerBox"],
        deliveryHaltChargeDay1: json["deliveryHaltChargeDay1"],
        deliveryHaltChargeDay2: json["deliveryHaltChargeDay2"],
        deliveryHaltChargeDay3: json["deliveryHaltChargeDay3"],
        deliveryHaltChargeDay4: json["deliveryHaltChargeDay4"],
        haltChargeLoadingPoint: json["haltChargeLoadingPoint"],
        vehicleCharge: json["vehicleCharge"],
        misc1: json["misc1"],
        minChargableWeight: json["minChargableWeight"],
        perCftCost: json["perCFTCost"],
        minChargableCft: json["minChargableCFT"],
        minGrAmount: json["minGRAmount"],
        lateDeliveryCharges: json["lateDeliveryCharges"],
        coMinLiability: json["coMinLiability"],
        coMaxLiability: json["coMaxLiability"],
        fsc: json["fsc"],
        productRestrictionPenalization: json["productRestrictionPenalization"],
        mode: json["mode"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "docketChargeCosts":
            List<dynamic>.from(docketChargeCosts.map((x) => x.toJson())),
        "weightChargeCosts":
            List<dynamic>.from(weightChargeCosts.map((x) => x.toJson())),
        "fovValue": fovValue,
        "minWeightDocket": minWeightDocket,
        "minWeightPerBox": minWeightPerBox,
        "fuelCharge": fuelCharge,
        "gst": gst,
        "maxLiabilityDocket": maxLiabilityDocket,
        "remoteOTAPickupCharge": remoteOtaPickupCharge,
        "remoteOTADeliveryCharge": remoteOtaDeliveryCharge,
        "packagingCostPerBox": packagingCostPerBox,
        "codChargePerDocket": codChargePerDocket,
        "codChargePerBox": codChargePerBox,
        "deliveryHaltChargeDay1": deliveryHaltChargeDay1,
        "deliveryHaltChargeDay2": deliveryHaltChargeDay2,
        "deliveryHaltChargeDay3": deliveryHaltChargeDay3,
        "deliveryHaltChargeDay4": deliveryHaltChargeDay4,
        "haltChargeLoadingPoint": haltChargeLoadingPoint,
        "vehicleCharge": vehicleCharge,
        "misc1": misc1,
        "minChargableWeight": minChargableWeight,
        "perCFTCost": perCftCost,
        "minChargableCFT": minChargableCft,
        "minGRAmount": minGrAmount,
        "lateDeliveryCharges": lateDeliveryCharges,
        "coMinLiability": coMinLiability,
        "coMaxLiability": coMaxLiability,
        "fsc": fsc,
        "productRestrictionPenalization": productRestrictionPenalization,
        "mode": mode,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}

class TChargeCost {
  TChargeCost({
    required this.slab,
    required this.cost,
    required this.id,
  });

  String slab;
  int cost;
  String id;

  factory TChargeCost.fromJson(Map<String, dynamic> json) => TChargeCost(
        slab: json["slab"],
        cost: json["cost"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "slab": slab,
        "cost": cost,
        "_id": id,
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
  });

  String name;
  String email;
  int phoneNo;
  String id;
  DateTime createdAt;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
