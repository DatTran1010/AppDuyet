import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/services/absent_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/utils/enum/api_error.dart';

class AbsentState {
  final bool isInit;
  bool isAbsent;
  AbsentState({required this.isInit, required this.isAbsent});

  AbsentState copyWith({bool? isInit, bool? isAbsent}) {
    return AbsentState(
        isInit: isInit ?? this.isInit, isAbsent: isAbsent ?? this.isAbsent);
  }
}

class AbsentNotifier extends StateNotifier<AbsentState> {
  AbsentNotifier(this._service)
      : super(AbsentState(isAbsent: false, isInit: true)) {
    init();
  }

  static final provider = StateNotifierProvider.autoDispose
      .family<AbsentNotifier, AbsentState, String>((ref, userName) {
    AbsentService service = ref.read(AbsentService.provider(userName));
    return AbsentNotifier(service);
  });
  final AbsentService _service;

  void init() async {
    bool absentStatus = await checkAbsent();
    state = state.copyWith(isAbsent: absentStatus, isInit: false);
  }

  Future<bool> checkAbsent() async {
    ServerLog log = await _service.checkAbsent();

    if (log.success) {
      return log.data;
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }

  Future<void> updateAbsent() async {
    ServerLog log = await _service.updateAbsent(!state.isAbsent);

    if (log.success) {
      if (log.data != null && log.data) {
        state = state.copyWith(isAbsent: !state.isAbsent);
      }
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }
}
