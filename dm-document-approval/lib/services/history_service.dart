import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/services/network_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/token_service.dart';

class HistoryService {
  static final provider = Provider.autoDispose.family<HistoryService, int>(
    (ref, docId) {
      final tokenService = ref.watch(TokenService.provider);
      final networkService = ref.watch(NetworkService.provider);
      return HistoryService(docId,
          tokenService: tokenService, networkService: networkService);
    },
  );
  final int docId;
  HistoryService(this.docId,
      {required this.tokenService, required this.networkService})
      : super();
  final TokenService tokenService;
  final NetworkService networkService;

  Future<ServerLog> getDocumentListHistory() async {
    String path = "DocumentHistory";
    var query = {"ID_DQT": "$docId"};
    return networkService.doHttpGet(path, tokenService.token, query: query);
  }
}
