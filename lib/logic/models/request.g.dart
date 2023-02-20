// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      DateTimeUtil.dateTimeFromString(json['thoI_GIAN'] as String),
    )
      ..id = json['iD_DQT'] as int?
      ..submitUserName = json['useR_CHUYEN'] as String?
      ..submitFullName = json['fulL_NAME_CHUYEN'] as String?
      ..documentName = json['teN_TAI_LIEU'] as String?
      ..docNum = json['doC_NUM'] as String?
      ..approvalStage = json['buoC_DUYET'] as String?
      ..opinion = json['y_KIEN'] as String?
      ..emergency = json['khaN_CAP'] as bool?
      ..isApproved = json['chaP_NHAN'] as bool?
      ..finished = json['keT_THUC'] as bool?;

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'iD_DQT': instance.id,
      'thoI_GIAN': DateTimeUtil.formattedDateTime(instance.date),
      'useR_CHUYEN': instance.submitUserName,
      'fulL_NAME_CHUYEN': instance.submitFullName,
      'teN_TAI_LIEU': instance.documentName,
      'doC_NUM': instance.docNum,
      'buoC_DUYET': instance.approvalStage,
      'y_KIEN': instance.opinion,
      'khaN_CAP': instance.emergency,
      'chaP_NHAN': instance.isApproved,
      'keT_THUC': instance.finished,
    };
