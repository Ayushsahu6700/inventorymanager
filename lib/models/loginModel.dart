import 'dart:convert';

LoginModel loginModelFromJson(Map<String, dynamic> json) =>
    LoginModel.fromJson(json);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.code,
    required this.user,
  });

  String code;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.createdById,
    required this.createdByType,
    required this.email,
    required this.name,
    required this.phoneNo,
    required this.id,
  });

  String createdById;
  String createdByType;
  String email;
  String name;
  int phoneNo;
  String id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdById: json["createdById"],
        createdByType: json["createdByType"],
        email: json["email"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdById": createdById,
        "createdByType": createdByType,
        "email": email,
        "name": name,
        "phoneNo": phoneNo,
        "id": id,
      };
}
