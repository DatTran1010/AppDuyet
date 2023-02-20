import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/services/network_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/token_service.dart';

class AbsentService {
  static final provider = Provider.family<AbsentService, String>(
    (ref, userName) {
      final tokenService = ref.watch(TokenService.provider);
      final networkService = ref.watch(NetworkService.provider);
      return AbsentService(userName,
          tokenService: tokenService, networkService: networkService);
    },
  );
  final String userName;
  AbsentService(this.userName,
      {required this.tokenService, required this.networkService});
  final TokenService tokenService;
  final NetworkService networkService;
  Future<ServerLog> checkAbsent() async {
    String path = "CheckAbsent/$userName";
    return networkService.doHttpGet(path, tokenService.token);
  }

  Future<ServerLog> updateAbsent(bool value) async {
    String path = "UpdateAbsent";
    var reqBody = {"isAbsent": value, "useR_NAME": userName};
    return networkService.doHttpPost(path, reqBody, tokenService.token);
  }
}
