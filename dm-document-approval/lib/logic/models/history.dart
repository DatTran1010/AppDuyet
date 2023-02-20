import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:viet_soft/utils/date_time_util.dart';
part 'history.g.dart';

@JsonSerializable(explicitToJson: true)
class History {
  @JsonKey(name: "iD_DQT")
  int? dqtId;
  @JsonKey(name: "iD_DQT_TRUOC")
  String? preDQTId;
  @JsonKey(name: "iD_DQT_GOC")
  String? originalDQTId;
  @JsonKey(
      name: "thoI_GIAN",
      fromJson: DateTimeUtil.dateTimeFromString,
      toJson: DateTimeUtil.formattedDateTime)
  DateTime date;
  @JsonKey(name: "iD_DQD")
  String? dqdId;
  @JsonKey(name: "teN_QUY_DINH")
  String? docSpecifiedName;
  @JsonKey(name: "iD_DTL")
  String? dtlId;
  @JsonKey(name: "teN_TAI_LIEU")
  String? docName;
  @JsonKey(name: "iD_DOC")
  String? docId;
  @JsonKey(name: "doC_NUM")
  String? docNum;
  @JsonKey(name: "iD_DU")
  String? duId;
  @JsonKey(name: "iD_DB")
  String? dbId;
  @JsonKey(name: "buoC_DUYET")
  String? approvalStage;
  @JsonKey(name: "iD_USER_CHUYEN")
  String? tranferUserId;
  @JsonKey(name: "useR_CHUYEN")
  String? tranferUser;
  @JsonKey(name: "iD_USER_DEN")
  String? arrivedUserId;
  @JsonKey(name: "useR_DEN")
  String? arrivedUser;
  @JsonKey(name: "y_KIEN")
  String? opinion;
  @JsonKey(name: "dinH_KEM")
  int? included;
  @JsonKey(name: "chaP_NHAN")
  int? agreement;
  @JsonKey(name: "khaN_CAP")
  int? emergency;
  @JsonKey(name: "keT_THUC")
  int? finished;
  @JsonKey(name: "taI_LIEU_DINH_KEM")
  String? documentLink;

  History(this.date);

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  static List<History> getListHistoryFromJson(dynamic map) {
    if (map == null) return [];

    var decoded = map is String ? json.decode(map) : map;
    return decoded
        .map<History>((dynamic json) => _$HistoryFromJson(json))
        .toList();
  }
}
