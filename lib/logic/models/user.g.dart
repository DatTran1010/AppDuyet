// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['iD_USER'] as int?
  ..teamId = json['iD_NHOM'] as int?
  ..userName = json['useR_NAME'] as String?
  ..fullName = json['fulL_NAME'] as String?
  ..password = json['password'] as String?
  ..description = json['description'] as String?
  ..userMail = json['useR_MAIL'] as String?
  ..userPhone = json['useR_PHONE'] as String?
  ..active = json['active'] as bool?
  ..ownID = json['iD_OWN'] as int?
  ..absence = json['vanG_MAT'] as int?
  ..pqUser = json['useR_PQ'] as String?
  ..lic = json['lic'] as bool?
  ..userIdInt = json['iD_USER_INT'] as int?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'iD_USER': instance.userId,
      'iD_NHOM': instance.teamId,
      'useR_NAME': instance.userName,
      'fulL_NAME': instance.fullName,
      'password': instance.password,
      'description': instance.description,
      'useR_MAIL': instance.userMail,
      'useR_PHONE': instance.userPhone,
      'active': instance.active,
      'iD_OWN': instance.ownID,
      'vanG_MAT': instance.absence,
      'useR_PQ': instance.pqUser,
      'lic': instance.lic,
      'iD_USER_INT': instance.userIdInt,
    };
