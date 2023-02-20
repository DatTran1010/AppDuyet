import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/logic/models/drop_down_database.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/services/login_service.dart';

import 'package:localstorage/localstorage.dart';
// class HistoryNotifier extends StateNotifier<List<History>> {
//   static final provider = StateNotifierProvider.autoDispose
//       .family<HistoryNotifier, List<History>, int>((ref, id) {
//     HistoryService service = ref.read(HistoryService.provider(id));
//     return HistoryNotifier(service);
//   });
//   final HistoryService _service;
//   HistoryNotifier(this._service) : super([]);

//   Future<void> getListHistory() async {
//     ServerLog log = await _service.getDocumentListHistory();
//     if (log.success) {
//       List<History> historyList =
//           History.getListHistoryFromJson(log.data["result"]);
//       if (historyList.isNotEmpty) {
//         historyList.sort((a, b) => a.date.compareTo(b.date));
//       }
//       state = historyList;
//     } else {
//       if (log.code == 401) {
//         throw APIError.unauthorized;
//       } else {
//         throw APIError.unknown;
//       }
//     }
//   }
// }

class LoginState {
  String userName = "";
  String password = "";
  String baseUrl = "";
  bool savePassword = false;
  var nameDatabase;
}

class LoginNotifier extends StateNotifier<LoginState> {
  static final provider =
      StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(((ref) {
    LoginService service = ref.read(LoginService.provider);
    return LoginNotifier(service);
  }));
  LoginNotifier(this.service) : super(LoginState()) {
    localLoginInfor();
  }

  final LoginService service;
  int? userId;
  int? requestId;

  final LocalStorage storage = new LocalStorage('localstorage_app');

  void localLoginInfor() async {
    await service.initHiveDatabase();
    await service.networkService.initHiveDatabase();
    LoginState newState = LoginState()
      ..savePassword = service.loginInfor?.isSaved ?? false
      ..userName = service.loginInfor?.userName ?? ""
      ..password = service.loginInfor?.password ?? ""
      ..baseUrl = service.networkService.baseUrl?.domain ?? ""
      ..nameDatabase = storage.getItem('dbname') == null
          ? null
          : (storage.getItem('dbname'));
    state = newState;
  }

  void setBaseUrl(String value) {
    state.baseUrl = value;
  }

  void setNameDataBase(var value) {
    state.nameDatabase = value;
  }

  void setUserName(String value) {
    state.userName = value;
  }

  void setPassword(String value) {
    state.password = value;
  }

  void toggleSavePassword() {
    if (state.savePassword) {
      service.clearLoginInfor();
    }
    LoginState newState = LoginState()
      ..savePassword = !state.savePassword
      ..userName = state.userName
      ..password = state.password;
    state = newState;
  }

  bool getSavePassword() {
    return state.savePassword;
  }

  Future<User> login() async {
    try {
      String uName = await service.login(state.userName, state.password);
      if (uName != "") {
        if (state.savePassword) {
          service.saveLoginInfor(
              userName: state.userName,
              password: state.password,
              isSaved: true);
        }
        User user = await service.getUserById(state.userName);
        return user;
      } else {
        throw Exception("Get User went wrong");
      }
    } catch (e) {
      throw Exception("Get User went wrong");
    }
  }

  Future<List<String>> getComboDatabase() async {
    try {
      List<String> list = await service.getComboDatabase();
      list = list;
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<void> updateDatabase() async {
    try {
      List<String> list = await service.getComboDatabase();
      list = list;
    } catch (e) {}
  }
}
