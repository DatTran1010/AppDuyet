import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:viet_soft/utils/date_time_util.dart';
part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  @JsonKey(name: "iD_DQT")
  int? id;
  @JsonKey(
      name: "thoI_GIAN",
      fromJson: DateTimeUtil.dateTimeFromString,
      toJson: DateTimeUtil.formattedDateTime)
  DateTime date;
  @JsonKey(name: "useR_CHUYEN")
  String? submitUserName;
  @JsonKey(name: "fulL_NAME_CHUYEN")
  String? submitFullName;
  @JsonKey(name: "teN_TAI_LIEU")
  String? documentName;
  @JsonKey(name: "doC_NUM")
  String? docNum;
  @JsonKey(name: "buoC_DUYET")
  String? approvalStage;
  @JsonKey(name: "y_KIEN")
  String? opinion;
  @JsonKey(name: "khaN_CAP")
  bool? emergency;
  @JsonKey(name: "chaP_NHAN")
  bool? isApproved;
  @JsonKey(name: "keT_THUC")
  bool? finished;

  Request(this.date);

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  static List<Request> listRequestFromJson(dynamic map) {
    if (map == null) return [];

    var decoded = map is String ? json.decode(map) : map;
    return decoded
        .map<Request>((dynamic json) => _$RequestFromJson(json))
        .toList();
  }
}
