class CurrentUserModel {
  CurrentUserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.type,
    this.salary,
    this.noOfLeaves,
    this.aadharDocumentId,
    this.contractDocumentId,
    this.profilePicDocumentId,
    this.createdByType,
    this.createdById,
    this.createdAt,
    this.v,
    this.designation,
    this.category,
    this.currentUserModelId,
  });

  String? id;
  String? name;
  String? email;
  int? phoneNo;
  String? type;
  int? salary;
  int? noOfLeaves;
  String? aadharDocumentId;
  String? contractDocumentId;
  String? profilePicDocumentId;
  String? createdByType;
  String? createdById;
  DateTime? createdAt;
  int? v;
  String? designation;
  String? category;
  String? currentUserModelId;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
        type: json["type"] == null ? null : json["type"],
        salary: json["salary"] == null ? null : json["salary"],
        noOfLeaves: json["noOfLeaves"] == null ? null : json["noOfLeaves"],
        aadharDocumentId:
            json["aadharDocumentId"] == null ? null : json["aadharDocumentId"],
        contractDocumentId: json["contractDocumentId"] == null
            ? null
            : json["contractDocumentId"],
        profilePicDocumentId: json["profilePicDocumentId"] == null
            ? null
            : json["profilePicDocumentId"],
        createdByType:
            json["createdByType"] == null ? null : json["createdByType"],
        createdById: json["createdById"] == null ? null : json["createdById"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"] == null ? null : json["__v"],
        designation: json["designation"] == null ? null : json["designation"],
        category: json["category"] == null ? null : json["category"],
        currentUserModelId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNo": phoneNo == null ? null : phoneNo,
        "type": type == null ? null : type,
        "salary": salary == null ? null : salary,
        "noOfLeaves": noOfLeaves == null ? null : noOfLeaves,
        "aadharDocumentId": aadharDocumentId == null ? null : aadharDocumentId,
        "contractDocumentId":
            contractDocumentId == null ? null : contractDocumentId,
        "profilePicDocumentId":
            profilePicDocumentId == null ? null : profilePicDocumentId,
        "createdByType": createdByType == null ? null : createdByType,
        "createdById": createdById == null ? null : createdById,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "__v": v == null ? null : v,
        "designation": designation == null ? null : designation,
        "category": category == null ? null : category,
        "id": currentUserModelId == null ? null : currentUserModelId,
      };
}
