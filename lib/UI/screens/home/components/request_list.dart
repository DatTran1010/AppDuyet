import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/components/request_container.dart';
import 'package:viet_soft/UI/screens/history/history_screen.dart';
import 'package:viet_soft/UI/screens/home/components/request_item.dart';
import 'package:viet_soft/UI/screens/update/update_screen.dart';
import 'package:viet_soft/logic/models/drop_down.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/home_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/handle_error.dart';
import 'package:viet_soft/utils/load_more_list.dart';

class RequestList extends ConsumerStatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  RequestList(
      {required this.user,
      required this.isApproved,
      this.dateFrom,
      this.dateTo,
      this.dtlId});
  final User user;
  final bool isApproved;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final DropdownModel? dtlId;

  @override
  RequestListState createState() => RequestListState();
}

class RequestListState extends ConsumerState<RequestList> {
  @override
  void initState() {
    super.initState();

    ref
        .read(RequestNotifier.provider(widget.user).notifier)
        .refresh(
            widget.isApproved, widget.dateFrom, widget.dateTo, widget.dtlId)
        .onError((error, stackTrace) {
      HandleError.handleUnauthorized(context, error);
    });
  }

  final ScrollController _controller = ScrollController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(RequestNotifier.provider(widget.user));

    final isLoading =
        ref.watch(RequestNotifier.provider(widget.user).notifier).isLoading;

    return RequestContainer(
      child: !isLoading
          ? LoadMoreList(
              onRefresh: () {
                ref
                    .read(RequestNotifier.provider(widget.user).notifier)
                    .refresh(widget.isApproved, widget.dateFrom, widget.dateTo,
                        widget.dtlId)
                    .onError((error, stackTrace) {
                  HandleError.handleUnauthorized(context, error);
                });
              },
              onLoadMore: () {
                ref
                    .read(RequestNotifier.provider(widget.user).notifier)
                    .loadMore(widget.isApproved, widget.dateFrom, widget.dateTo,
                        widget.dtlId)
                    .onError((error, stackTrace) {
                  HandleError.handleUnauthorized(context, error);
                });
              },
              child: ListView.builder(
                controller: _controller,
                itemCount: provider.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 16, bottom: index == provider.length - 1 ? 8 : 0),
                    child: RequestItem(
                      request: provider[index],
                      onTap: () async {
                        if (provider[index].isApproved!) {
                          CrossPlatform.transitionToPage(
                              context,
                              HistoryScreen(
                                requestId: provider[index].id!,
                                user: widget.user,
                                docNum: provider[index].docNum!,
                                callFromHomeScreen: true,
                              ));
                        } else {
                          bool? isUpdate = await CrossPlatform.transitionToPage(
                            context,
                            UpdateScreen(
                              requestId: provider[index].id!,
                              user: widget.user,
                            ),
                          );
                          if (isUpdate != null && isUpdate) {
                            ref
                                .read(RequestNotifier.provider(widget.user)
                                    .notifier)
                                .refresh(widget.isApproved, widget.dateFrom,
                                    widget.dateTo, widget.dtlId)
                                .onError((error, stackTrace) {
                              HandleError.handleUnauthorized(context, error);
                            });
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()),
            ),
    );
  }

  @override
  void didUpdateWidget(covariant RequestList oldWidget) {
    if (oldWidget.isApproved != widget.isApproved ||
        oldWidget.dateFrom != widget.dateFrom ||
        oldWidget.dateTo != widget.dateTo ||
        oldWidget.dtlId != widget.dtlId) {
      print("reload");
      print(
          "${widget.isApproved} - ${widget.dateFrom} - ${widget.dateTo} - ${widget.dtlId}");
      ref
          .read(RequestNotifier.provider(widget.user).notifier)
          .refresh(
              widget.isApproved, widget.dateFrom, widget.dateTo, widget.dtlId)
          .catchError((error, stackTrace) {
        print("handle error");
        HandleError.handleUnauthorized(context, error);
      });
      _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
    super.didUpdateWidget(oldWidget);
  }
}
