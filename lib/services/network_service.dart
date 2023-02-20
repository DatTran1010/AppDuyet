import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viet_soft/logic/models/base_url.dart';
import 'package:viet_soft/logic/models/database_name.dart';
import 'package:viet_soft/logic/models/drop_down_database.dart';
import 'package:viet_soft/services/server_log.dart';

class NetworkService {
  NetworkService();
  static final provider = Provider<NetworkService>((ref) {
    return NetworkService();
  });

  String baseUrlString = "";
  final String baseUnencodedPath = "/api/Auth/";
  Box<BaseUrl>? baseUrlBox;
  Box<DatabaseName>? dbNameBox;
  BaseUrl? baseUrl;
  DatabaseName? dbName;

  Map<String, String> header(String? token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<ServerLog> doHttpGet(path, token,
      {Map<String, dynamic>? query}) async {
    Uri url = Uri();
    if (baseUrl!.domain.contains("https")) {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.https(urlString, baseUnencodedPath + path, query);
    } else {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.http(urlString, baseUnencodedPath + path, query);
    }
    print(url.toString());
    http.Response response = await http.get(url, headers: header(token));
    return ServerLog.fromReponse(response);
  }

  Future<ServerLog> getDataAPI(path, {Map<String, dynamic>? query}) async {
    Uri url = Uri();
    if (baseUrl!.domain.contains("https")) {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.https(urlString, baseUnencodedPath + path, query);
    } else {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.http(urlString, baseUnencodedPath + path, query);
    }
    print(url.toString());
    http.Response response = await http.get(url);
    return ServerLog.fromReponse(response);
  }

  Future<ServerLog> doHttpPost(path, requestBody, token,
      {Map<String, dynamic>? query}) async {
    Uri url = Uri();
    print(baseUrl!.domain);
    if (baseUrl!.domain.contains("https")) {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.https(urlString, baseUnencodedPath + path, query);
    } else {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.http(urlString, baseUnencodedPath + path, query);
    }
    print(url.toString());
    var body = jsonEncode(requestBody);
    http.Response response =
        await http.post(url, body: body, headers: header(token));
    return ServerLog.fromReponse(response);
  }

  Future<ServerLog> doHttpPut(path, requestBody, token,
      {Map<String, dynamic>? query}) async {
    Uri url = Uri();
    if (baseUrl!.domain.contains("https")) {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.https(urlString, baseUnencodedPath + path, query);
    } else {
      String urlString = baseUrl!.domain.split("://")[1];
      url = Uri.http(urlString, baseUnencodedPath + path, query);
    }
    var body = jsonEncode(requestBody);
    http.Response response =
        await http.put(url, body: body, headers: header(token));
    return ServerLog.fromReponse(response);
  }

  Future<void> initHiveDatabase() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BaseUrlAdapter());
    }

    baseUrlBox = await Hive.openBox<BaseUrl>('baseUrlBox');
    try {
      baseUrl = baseUrlBox!.getAt(0);
      print("hive : ${baseUrl!.domain}");
    } catch (e) {
      BaseUrl baseUrl = BaseUrl("");
      baseUrlBox!.add(baseUrl);
    }
  }

  Future<void> saveLoginInfor({required String value}) async {
    BaseUrl? baseUrlLocal = baseUrlBox!.getAt(0);
    baseUrlLocal!.domain = value;
    await baseUrlLocal.save();
  }

  void clearLoginInfor() {
    BaseUrl? baseUrl = baseUrlBox!.getAt(0);
    baseUrl!.domain = "";
    baseUrl.save();
  }
}
