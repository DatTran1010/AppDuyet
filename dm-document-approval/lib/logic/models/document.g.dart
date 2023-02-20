// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      DateTimeUtil.dateTimeFromString(json['thoI_GIAN'] as String),
    )
      ..docSpecifiedName = json['teN_QUY_DINH'] as String?
      ..docName = json['teN_TAI_LIEU'] as String?
      ..docNum = json['doC_NUM'] as String?
      ..tranferUserId = json['iD_USER_CHUYEN'] as int?
      ..tranferUser = json['useR_CHUYEN'] as String?
      ..arrivedUserId = json['iD_USER_DEN'] as int?
      ..arrivedUser = json['useR_DEN'] as String?
      ..requestContent = json['noI_DUNG_YEU_CAU'] as String?
      ..isIncluded = json['dinH_KEM'] as String?
      ..includedDoc = json['taI_LIEU_DINH_KEM'] as String?
      ..emergency = json['khaN_CAP'] as bool?;

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'teN_QUY_DINH': instance.docSpecifiedName,
      'teN_TAI_LIEU': instance.docName,
      'doC_NUM': instance.docNum,
      'iD_USER_CHUYEN': instance.tranferUserId,
      'useR_CHUYEN': instance.tranferUser,
      'iD_USER_DEN': instance.arrivedUserId,
      'useR_DEN': instance.arrivedUser,
      'noI_DUNG_YEU_CAU': instance.requestContent,
      'dinH_KEM': instance.isIncluded,
      'taI_LIEU_DINH_KEM': instance.includedDoc,
      'khaN_CAP': instance.emergency,
      'thoI_GIAN': DateTimeUtil.formattedDateTime(instance.date),
    };
