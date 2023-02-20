import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class DatabaseName extends HiveObject {
  @HiveField(0)
  var dbName;

  DatabaseName(this.dbName);
}
