import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoadMoreList({this.child, this.onRefresh, this.onLoadMore});
  final Widget? child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  @override
  State<LoadMoreList> createState() => _LoadMoreListState();
}

class _LoadMoreListState extends State<LoadMoreList> {
  RefreshController refreshController = RefreshController();

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: const WaterDropHeader(),
      footer: const ClassicFooter(
        idleText: 'Pull to load more',
        idleIcon: Icon(
          Icons.keyboard_arrow_up,
        ),
        loadingText: 'Loading',
        noDataText: 'No more data',
        canLoadingText: 'Release to load',
        failedText: 'Failed to load data',
      ),
      child: widget.child,
    );
  }

  void _onRefresh() {
    if (widget.onRefresh != null) {
      widget.onRefresh!();
    }
    refreshController.refreshCompleted();
  }

  void _onLoading() {
    if (widget.onLoadMore != null) {
      widget.onLoadMore!();
    }
    refreshController.loadComplete();
  }
}
