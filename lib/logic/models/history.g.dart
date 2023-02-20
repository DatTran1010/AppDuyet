// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      DateTimeUtil.dateTimeFromString(json['thoI_GIAN'] as String),
    )
      ..dqtId = json['iD_DQT'] as int?
      ..preDQTId = json['iD_DQT_TRUOC'] as String?
      ..originalDQTId = json['iD_DQT_GOC'] as String?
      ..dqdId = json['iD_DQD'] as String?
      ..docSpecifiedName = json['teN_QUY_DINH'] as String?
      ..dtlId = json['iD_DTL'] as String?
      ..docName = json['teN_TAI_LIEU'] as String?
      ..docId = json['iD_DOC'] as String?
      ..docNum = json['doC_NUM'] as String?
      ..duId = json['iD_DU'] as String?
      ..dbId = json['iD_DB'] as String?
      ..approvalStage = json['buoC_DUYET'] as String?
      ..tranferUserId = json['iD_USER_CHUYEN'] as String?
      ..tranferUser = json['useR_CHUYEN'] as String?
      ..arrivedUserId = json['iD_USER_DEN'] as String?
      ..arrivedUser = json['useR_DEN'] as String?
      ..opinion = json['y_KIEN'] as String?
      ..included = json['dinH_KEM'] as int?
      ..agreement = json['chaP_NHAN'] as int?
      ..emergency = json['khaN_CAP'] as int?
      ..finished = json['keT_THUC'] as int?
      ..documentLink = json['taI_LIEU_DINH_KEM'] as String?;

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'iD_DQT': instance.dqtId,
      'iD_DQT_TRUOC': instance.preDQTId,
      'iD_DQT_GOC': instance.originalDQTId,
      'thoI_GIAN': DateTimeUtil.formattedDateTime(instance.date),
      'iD_DQD': instance.dqdId,
      'teN_QUY_DINH': instance.docSpecifiedName,
      'iD_DTL': instance.dtlId,
      'teN_TAI_LIEU': instance.docName,
      'iD_DOC': instance.docId,
      'doC_NUM': instance.docNum,
      'iD_DU': instance.duId,
      'iD_DB': instance.dbId,
      'buoC_DUYET': instance.approvalStage,
      'iD_USER_CHUYEN': instance.tranferUserId,
      'useR_CHUYEN': instance.tranferUser,
      'iD_USER_DEN': instance.arrivedUserId,
      'useR_DEN': instance.arrivedUser,
      'y_KIEN': instance.opinion,
      'dinH_KEM': instance.included,
      'chaP_NHAN': instance.agreement,
      'khaN_CAP': instance.emergency,
      'keT_THUC': instance.finished,
      'taI_LIEU_DINH_KEM': instance.documentLink,
    };
