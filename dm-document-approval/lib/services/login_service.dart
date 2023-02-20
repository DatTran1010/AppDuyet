import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:viet_soft/logic/models/drop_down_database.dart';
import 'package:viet_soft/logic/models/login_infor.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/services/network_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/token_service.dart';

class LoginService {
  static final provider = Provider<LoginService>(
    (ref) {
      final tokenService = ref.watch(TokenService.provider);
      final networkService = ref.watch(NetworkService.provider);
      return LoginService(
          tokenService: tokenService, networkService: networkService);
    },
  );
  LoginService({required this.tokenService, required this.networkService});
  final TokenService tokenService;
  final NetworkService networkService;
  User? user;
  Box<LoginInfor>? loginInforBox;
  LoginInfor? loginInfor;

  Future<String> login(String userName, String password) async {
    String loginPath = "Login";
    var firebaseToken = await FirebaseMessaging.instance.getToken();
    print("token firebase: $firebaseToken");
    var loginRequestBody = {
      "userName": userName,
      "password": password,
      "firebaseToken": firebaseToken
    };
    ServerLog logInLog = await networkService.doHttpPost(
        loginPath, loginRequestBody, tokenService.token);

    if (logInLog.success) {
      tokenService.token = logInLog.data["token"];

      return logInLog.data["useR_NAME"] ?? "";
    } else {
      throw Exception(logInLog.message!);
    }
  }

  Future<User> getUserById(String userName) async {
    String path = "GetByIdUsers/$userName";

    ServerLog getUserLog =
        await networkService.doHttpGet(path, tokenService.token);
    if (getUserLog.success) {
      User userResponse = User.fromJson(getUserLog.data[0]);
      user = userResponse;
      return userResponse;
    } else {
      throw Exception(getUserLog.message!);
    }
  }

  Future<List<String>> getComboDatabase() async {
    String url = "getComboDatabase";
    ServerLog log = await networkService.getDataAPI(url);
    if (log.success) {
      List documentTypeJson = log.data;
      List<String> data =
          documentTypeJson.map((e) => e["namE_DATA"].toString()).toList();
      return data;
    }
    return [];
  }

  Future<void> initHiveDatabase() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginInforAdapter());
    }

    loginInforBox = await Hive.openBox<LoginInfor>('loginInforBox');

    try {
      loginInfor = loginInforBox!.getAt(0);
    } catch (e) {
      LoginInfor newLoginInfor = LoginInfor("", "", false);
      loginInforBox!.add(newLoginInfor);
    }
  }

  Future<ServerLog> updateConection(String sDatabaseName) async {
    String url = "UpdateConnection/$sDatabaseName";
    return networkService.getDataAPI(url);
  }

  void saveLoginInfor(
      {required String userName,
      required String password,
      required bool isSaved}) {
    LoginInfor? localLoginInfor = loginInforBox!.getAt(0);
    localLoginInfor!.userName = userName;
    localLoginInfor.password = password;
    localLoginInfor.isSaved = isSaved;
    localLoginInfor.save();
  }

  void clearLoginInfor() {
    LoginInfor? localLoginInfor = loginInforBox!.getAt(0);
    localLoginInfor!.userName = "";
    localLoginInfor.password = "";
    localLoginInfor.isSaved = false;
    localLoginInfor.save();
  }
}
