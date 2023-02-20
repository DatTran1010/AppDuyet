import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/services/history_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/utils/enum/api_error.dart';

import '../logic/models/history.dart';

class HistoryNotifier extends StateNotifier<List<History>> {
  static final provider = StateNotifierProvider.autoDispose
      .family<HistoryNotifier, List<History>, int>((ref, id) {
    HistoryService service = ref.read(HistoryService.provider(id));
    return HistoryNotifier(service);
  });
  final HistoryService _service;
  HistoryNotifier(this._service) : super([]);

  Future<void> getListHistory() async {
    ServerLog log = await _service.getDocumentListHistory();
    if (log.success) {
      List<History> historyList =
          History.getListHistoryFromJson(log.data["result"]);
      if (historyList.isNotEmpty) {
        historyList.sort((a, b) => a.date.compareTo(b.date));
      }
      state = historyList;
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }
}
