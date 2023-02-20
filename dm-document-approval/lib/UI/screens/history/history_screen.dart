import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/components/body_container.dart';
import 'package:viet_soft/UI/components/drawer.dart';
import 'package:viet_soft/UI/components/vietsoft_appbar.dart';
import 'package:viet_soft/UI/components/vietsoft_bottom_bar.dart';
import 'package:viet_soft/UI/components/vietsoft_button.dart';
import 'package:viet_soft/UI/components/vietsoft_divider.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';
import 'package:viet_soft/UI/screens/history/components/history_item.dart';
import 'package:viet_soft/UI/screens/history/components/history_request_info.dart';
import 'package:viet_soft/UI/screens/home/home_screen.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/history_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/handle_error.dart';
import 'package:viet_soft/utils/url_launch_util.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen(
      {Key? key,
      required this.requestId,
      required this.user,
      required this.docNum,
      this.callFromHomeScreen = false})
      : super(key: key);
  final User user;
  final int requestId;
  final String docNum;
  final bool callFromHomeScreen;
  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    ref
        .read(HistoryNotifier.provider(widget.requestId).notifier)
        .getListHistory()
        .onError((error, stackTrace) {
      HandleError.handleUnauthorized(context, error);
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _historyScaffoldState =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(HistoryNotifier.provider(widget.requestId));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _historyScaffoldState,
        bottomNavigationBar: const VietSoftBottomBar(),
        backgroundColor: VietSoftColor.backgroundGreen,
        drawer:  VietSoftDrawer(user: widget.user,),
        body: SafeArea(
          child: Column(
            children: [
              VietSoftAppBar(
                onTap: () {
                  _historyScaffoldState.currentState!.openDrawer();
                },
                title: ResString.approvalHistory,
                userName: widget.user.userName!,
                userId: widget.user.userId!,
              ),
              Expanded(
                child: BodyContainer(
                  topMargin: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: HistoryRequestInfo(docNum: widget.docNum),
                            ),
                            VietSoftDivider(
                              padding: EdgeInsets.only(
                                  top: VietSoftSize.getSize(112, context),
                                  right: 10,
                                  left: 10),
                            ),
                            Expanded(
                                child: provider.isNotEmpty
                                    ? ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: index == 0 ? 8 : 16.0),
                                            child: HistoryItem(
                                              approvalHistory: provider[index],
                                              onDocLinkTap: () {
                                                if (provider[index]
                                                        .documentLink !=
                                                    null) {
                                                  URLLauchUtil.viewFile(
                                                      provider[index]
                                                          .documentLink);
                                                }
                                              },
                                            ),
                                          );
                                        },
                                        itemCount: provider.length)
                                    : const Center(
                                        child: Text("Không có lịch sử duyệt"),
                                      ))
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Row(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: VietSoftButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                radius: 14,
                                buttonTitle: "Thông tin duyệt",
                                darkBtnColor: VietSoftColor.darkLoginTextColor,
                                lightBtColor: VietSoftColor.lightLoginTextColor,
                                onTap: () {
                                  CrossPlatform.backTransitionPage(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: VietSoftButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                radius: 14,
                                buttonTitle: ResString.home,
                                darkBtnColor: VietSoftColor.darkBackgroundGreen,
                                lightBtColor:
                                    VietSoftColor.lightBackgroundGreen,
                                onTap: () {
                                  CrossPlatform.pushAndRemoveAll(
                                      context, HomeScreen(user: widget.user));
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
