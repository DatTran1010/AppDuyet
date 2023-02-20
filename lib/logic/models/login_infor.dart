import 'package:hive_flutter/hive_flutter.dart';

part 'login_infor.g.dart';

@HiveType(typeId: 0)
class LoginInfor extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String password;
  @HiveField(2)
  bool isSaved;

  LoginInfor(this.userName, this.password, this.isSaved);
}
