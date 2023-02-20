// ignore_for_file: void_checks

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/logic/models/drop_down.dart';
import 'package:viet_soft/logic/models/drop_down_nuq.dart';
import 'package:viet_soft/logic/models/request.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/services/home_service.dart';
import 'package:viet_soft/services/server_log.dart';
import 'package:viet_soft/utils/enum/api_error.dart';

class HomeState {
  final bool isApproved;
  DateTime? dateFrom;
  DateTime? dateTo;
  final DropdownModel? dtlId;
  final DropDownNUQModel? nuqId;
  HomeState(
      {required this.isApproved,
      this.dateFrom,
      this.dateTo,
      this.dtlId,
      this.nuqId});
  HomeState copyWith(
      {bool? isApproved,
      List<Request>? requestList,
      DateTime? dateFrom,
      DateTime? dateTo,
      DropdownModel? dtlId,
      DropDownNUQModel? nuqID}) {
    return HomeState(
        isApproved: isApproved ?? this.isApproved,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        dtlId: dtlId ?? this.dtlId,
        nuqId: nuqId ?? this.nuqId);
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  static final provider = StateNotifierProvider.autoDispose
      .family<HomeNotifier, HomeState, User>((ref, user) {
    return HomeNotifier();
  });

  HomeNotifier()
      : super(HomeState(
          isApproved: false,
        ));

  void setDateFrom(DateTime value) {
    state = state.copyWith(dateFrom: value);
  }

  void setDateTo(DateTime value) {
    state = state.copyWith(dateTo: value);
  }

  void toggleIsApproved() {
    state = state.copyWith(isApproved: !state.isApproved);
  }

  void setDtlId(DropdownModel value) {
    state = state.copyWith(dtlId: value);
  }
}

final documentTypeProvider =
    FutureProvider.family<List<DropdownModel>, User>((ref, user) async {
  HomeService service = ref.read(HomeService.provider(user));
  List<DropdownModel> queryList = await service.getListDropDownModel();
  queryList = [DropdownModel(0, ResString.inputDocType)] + queryList;
  return queryList;
});

class RequestNotifier extends StateNotifier<List<Request>> {
  static final provider = StateNotifierProvider.autoDispose
      .family<RequestNotifier, List<Request>, User>((ref, user) {
    HomeService service = ref.read(HomeService.provider(user));
    return RequestNotifier(service);
  });
  RequestNotifier(this.service) : super([]);
  final HomeService service;

  int currentPage = 1;

  bool isLoading = true;

  Future<void> getListRequest(bool isApproved, DateTime? dateFrom,
      DateTime? dateTo, DropdownModel? dtlIdModel) async {
    int? dltId = dtlIdModel == null
        ? null
        : dtlIdModel.id != 1000
            ? dtlIdModel.id
            : null;

    ServerLog log = await service.getListRequest(isApproved, true,
        dateFrom: dateFrom, dateTo: dateTo, dtlId: dltId, page: currentPage);
    isLoading = false;
    if (log.success) {
      state = Request.listRequestFromJson(log.data["result"]);
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }

  Future<void> refresh(bool isApproved, DateTime? dateFrom, DateTime? dateTo,
      DropdownModel? dtlIdModel) async {
    currentPage = 1;

    int? dltId = dtlIdModel == null
        ? null
        : dtlIdModel.id != 1000
            ? dtlIdModel.id
            : null;
    ServerLog log = await service.getListRequest(isApproved, true,
        dateFrom: dateFrom, dateTo: dateTo, dtlId: dltId, page: currentPage);
    isLoading = false;
    if (log.success) {
      state = Request.listRequestFromJson(log.data["result"]);
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }

  Future<List<DropDownNUQModel>> getListDropModel(int dqtId) async {
    List<DropDownNUQModel> list = await service.getListNUQDropDownModel(dqtId);
    return list;
  }

  Future<void> loadMore(bool isApproved, DateTime? dateFrom, DateTime? dateTo,
      DropdownModel? dtlIdModel) async {
    currentPage += 1;
    int? dltId = dtlIdModel == null
        ? null
        : dtlIdModel.id != 1000
            ? dtlIdModel.id
            : null;
    ServerLog log = await service.getListRequest(isApproved, true,
        dateFrom: dateFrom, dateTo: dateTo, dtlId: dltId, page: currentPage);
    isLoading = false;
    if (log.success) {
      List<Request> result = Request.listRequestFromJson(log.data["result"]);
      state = [...state, ...result];
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }

  Future<void> logOut() async {
    ServerLog log = await service.deleteToken();
    if (log.success) {
      // List<Request> result = Request.listRequestFromJson(log.data["result"]);
      // state = [...state, ...result];
    } else {
      if (log.code == 401) {
        throw APIError.unauthorized;
      } else {
        throw APIError.unknown;
      }
    }
  }
}
