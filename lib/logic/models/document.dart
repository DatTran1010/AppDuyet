import 'package:json_annotation/json_annotation.dart';
import 'package:viet_soft/utils/date_time_util.dart';
part 'document.g.dart';
@JsonSerializable(explicitToJson: true)
class Document {
  @JsonKey(name: "teN_QUY_DINH")
  String? docSpecifiedName;
  @JsonKey(name: "teN_TAI_LIEU")
  String? docName;
  @JsonKey(name: "doC_NUM")
  String? docNum;
  @JsonKey(name: "iD_USER_CHUYEN")
  int? tranferUserId;
  @JsonKey(name: "useR_CHUYEN")
  String? tranferUser;
  @JsonKey(name: "iD_USER_DEN")
  int? arrivedUserId;
  @JsonKey(name: "useR_DEN")
  String? arrivedUser;
  @JsonKey(name: "noI_DUNG_YEU_CAU")
  String? requestContent;
  @JsonKey(name: "dinH_KEM")
  String? isIncluded;
  @JsonKey(name: "taI_LIEU_DINH_KEM")
  String? includedDoc;
  @JsonKey(name: "khaN_CAP")
  bool? emergency;
  @JsonKey(
      name: "thoI_GIAN",
      fromJson: DateTimeUtil.dateTimeFromString,
      toJson: DateTimeUtil.formattedDateTime)
  DateTime date;

  Document(this.date);

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
