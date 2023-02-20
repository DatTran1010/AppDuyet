import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/screens/home/home_screen.dart';
import 'package:viet_soft/logic/models/document.dart';
import 'package:viet_soft/logic/models/drop_down_nuq.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/services/update_service.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/handle_error.dart';

import '../UI/constants/resource_string.dart';

class UpdateNotifier extends StateNotifier<Document?> {
  static final provider = StateNotifierProvider.autoDispose
      .family<UpdateNotifier, Document?, int>((ref, id) {
    UpdateService service = ref.read(UpdateService.provider(id));
    return UpdateNotifier(service);
  });

  final UpdateService _service;
  UpdateNotifier(this._service) : super(null);

  Future<void> getDocument() async {
    ServerLog log = await _service.getDocumentById();

    if (log.success) {
      Document document = Document.fromJson(log.data);
      state = document;
    } else {
      HandleError.throwAPIError(log.code);
    }
  }

  Future<List> getComboNUQ(int requestId, String? userName) async {
    List<DropDownNUQModel> list =
        await _service.getListNUQDropDownModel(requestId, userName);
    list = [DropDownNUQModel(0, ResString.nguoiUQ)] + list;
    return list;
  }
}

class UpdateState {
  final bool isApproved;
  String opinion;
  UpdateState({required this.isApproved, required this.opinion});

  UpdateState copyWith({String? opinion, bool? isApproved}) {
    return UpdateState(
        isApproved: isApproved ?? this.isApproved,
        opinion: opinion ?? this.opinion);
  }
}

class ApprovalNotifier extends StateNotifier<UpdateState> {
  ApprovalNotifier(this._service)
      : super(UpdateState(isApproved: false, opinion: ""));

  static final provider = StateNotifierProvider.autoDispose
      .family<ApprovalNotifier, UpdateState, int>((ref, id) {
    UpdateService service = ref.read(UpdateService.provider(id));
    return ApprovalNotifier(service);
  });
  final UpdateService _service;
  void toggleApproved() {
    state = state.copyWith(isApproved: !state.isApproved);
  }

  void updateApproval(int dqtId, String userName, int idNUQ,
      BuildContext context, User user) async {
    ServerLog log = await _service.updateApproval(
        dqtId, userName, idNUQ, state.isApproved ? 1 : 0, state.opinion);
    if (log.success) {
      // ignore: use_build_context_synchronously
      CrossPlatform.pushAndRemoveAll(context, HomeScreen(user: user));
      CrossPlatform.showSuccesSnackbar(context, "Cập nhật thành công");
    } else {
      if (log.code == 401) {
        // ignore: use_build_context_synchronously
        Navigator.popUntil(context, ModalRoute.withName('/'));
        // ignore: use_build_context_synchronously
        CrossPlatform.showErrorSnackbar(
            context, "Hết hạn token! Vui lòng đăng nhập lại");
      } else {
        // ignore: use_build_context_synchronously
        CrossPlatform.showErrorSnackbar(context, "Unknown error");
      }
    }
  }
}
