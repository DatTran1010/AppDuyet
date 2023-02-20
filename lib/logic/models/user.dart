import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: "iD_USER")
  int? userId;
  @JsonKey(name: "iD_NHOM")
  int? teamId;
  @JsonKey(name: "useR_NAME")
  String? userName;
  @JsonKey(name: "fulL_NAME")
  String? fullName;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "useR_MAIL")
  String? userMail;
  @JsonKey(name: "useR_PHONE")
  String? userPhone;
  @JsonKey(name: "active")
  bool? active;
  @JsonKey(name: "iD_OWN")
  int? ownID;
  @JsonKey(name: "vanG_MAT")
  int? absence;
  @JsonKey(name: "useR_PQ")
  String? pqUser;
  @JsonKey(name: "lic")
  bool? lic;
  @JsonKey(name: "iD_USER_INT")
  int? userIdInt;

  User();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}