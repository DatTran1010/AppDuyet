import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/services/network_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/token_service.dart';

import '../logic/models/drop_down_nuq.dart';

class UpdateService {
  static final provider = Provider.autoDispose.family<UpdateService, int>(
    (ref, id) {
      final tokenService = ref.watch(TokenService.provider);
      final networkService = ref.watch(NetworkService.provider);
      return UpdateService(id,
          tokenService: tokenService, networkService: networkService);
    },
  );

  final int id;
  UpdateService(this.id,
      {required this.networkService, required this.tokenService});
  final NetworkService networkService;
  final TokenService tokenService;
  Future<ServerLog> getDocumentById() async {
    String url = "DocumentDetail/$id";
    return networkService.doHttpGet(url, tokenService.token);
  }

  Future<List<DropDownNUQModel>> getListNUQDropDownModel(
      int dqtID, String? userName) async {
    String url = "getComboNguoiUQ/$dqtID";
    var query = {
      "USER_NAME": "$userName",
    };
    ServerLog log =
        await networkService.doHttpGet(url, tokenService.token, query: query);
    if (log.success) {
      print(log.data);
      List documentTypeJson = log.data;
      return documentTypeJson
          .map((e) => DropDownNUQModel(e["iD_NUQ"], e["teN_NUQ"]))
          .toList();
    }
    return [];
  }

  Future<ServerLog> updateApproval(
      int dqtId, String userName, int idNUQ, int approval, String opinion) {
    String path = "UpdateApproval";
    var query = {
      "ID_DQT": "$dqtId",
      "USER_NAME": userName,
      "iCot1": "$approval",
      "ID_NUQ": "$idNUQ",
      "SCot1": opinion,
    };
    return networkService.doHttpPut(path, {}, tokenService.token, query: query);
  }
}
