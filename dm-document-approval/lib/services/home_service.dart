import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/logic/models/drop_down.dart';
import 'package:viet_soft/logic/models/drop_down_nuq.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/services/network_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/token_service.dart';

class HomeService {
  static final provider = Provider.autoDispose.family<HomeService, User>(
    (ref, user) {
      final tokenService = ref.watch(TokenService.provider);
      final networkService = ref.watch(NetworkService.provider);
      return HomeService(user,
          tokenService: tokenService, networkService: networkService);
    },
  );
  HomeService(this.user,
      {required this.tokenService, required this.networkService});
  final TokenService tokenService;
  final NetworkService networkService;
  final User user;

  Future<ServerLog> getListRequest(bool isApproved, bool isAscOrder,
      {DateTime? dateFrom,
      DateTime? dateTo,
      int page = 1,
      int limit = 20,
      int? dtlId,
      String? userName}) async {
    final query = {
      "IsApproved": "$isApproved",
      "IsAscOrder": "$isAscOrder",
      "USER_NAME": "${user.userName}",
      "Page": "$page",
      "Limit": "$limit"
    };

    if (dateFrom != null) {
      DateTime selectedDateFrom =
          DateTime(dateFrom.year, dateFrom.month, dateFrom.day, 00, 00, 00);

      query["DateFrom"] = selectedDateFrom.toIso8601String();
    }
    if (dateTo != null) {
      DateTime selectedDateTo =
          DateTime(dateTo.year, dateTo.month, dateTo.day, 23, 59, 59);
      query["DateTo"] = selectedDateTo.toIso8601String();
    }
    if (dtlId != null) query["ID_DTL"] = "$dtlId";
    if (userName != null) query["USER_NAME"] = userName;

    return networkService.doHttpGet("HomePages", tokenService.token,
        query: query);
  }

  Future<List<DropdownModel>> getListDropDownModel() async {
    ServerLog log =
        await networkService.doHttpGet("HomePages", tokenService.token);
    if (log.success) {
      List documentTypeJson = log.data["querySelectBox"] as List;
      return documentTypeJson
          .map((e) => DropdownModel(e["iD_DTL"], e["teN_TAI_LIEU"]))
          .toList();
    }
    return [];
  }

  Future<List<DropDownNUQModel>> getListNUQDropDownModel(int requestId) async {
    String url = "getComboNguoiUQ/$requestId";
    ServerLog log = await networkService.doHttpGet(url, tokenService.token);
    if (log.success) {
      List documentTypeJson = log.data[""] as List;
      return documentTypeJson
          .map((e) => DropDownNUQModel(e["iD_NUQ"], e["ten_NUQ"]))
          .toList();
    }
    return [];
  }

  Future<ServerLog> deleteToken() async {
    final String? userName = user.userName;
    String url = "UpdateLogout/$userName";
    // var reqBody = {"id": user.userId};
    return networkService.doHttpPost(url, userName, tokenService.token);
  }
}
