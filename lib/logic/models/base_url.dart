import 'package:hive_flutter/hive_flutter.dart';

part 'base_url.g.dart';

@HiveType(typeId: 1)
class BaseUrl extends HiveObject {
  @HiveField(0)
  String domain;

  BaseUrl(this.domain);
}
