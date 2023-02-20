import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/components/body_container.dart';
import 'package:viet_soft/UI/components/drawer.dart';
import 'package:viet_soft/UI/components/vietsoft_appbar.dart';
import 'package:viet_soft/UI/components/vietsoft_bottom_bar.dart';
import 'package:viet_soft/UI/components/vietsoft_checkbox.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/screens/home/components/filter_component.dart';
import 'package:viet_soft/UI/screens/home/components/request_list.dart';
import 'package:viet_soft/logic/models/request.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/home_repository.dart';

import '../../../utils/cross_platform.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  final GlobalKey<ScaffoldState> _homeScaffoldState =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(HomeNotifier.provider(user));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _homeScaffoldState,
        bottomNavigationBar: const VietSoftBottomBar(),
        backgroundColor: VietSoftColor.backgroundGreen,
        drawer: VietSoftDrawer(
          user: user,
        ),
        body: SafeArea(
          child: Column(
            children: [
              VietSoftAppBar(
                title: "Home",
                userName: user.userName!,
                onTap: () {
                  _homeScaffoldState.currentState!.openDrawer();
                },
                userId: user.userId!,
              ),
              Expanded(
                child: BodyContainer(
                  topMargin: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: FilterComponent(user),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Check box --------------------
                            const Text(
                              ResString.approved,
                              style: TextStyle(color: VietSoftColor.title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: VietSoftCheckBox(
                                onTap: () {
                                  ref
                                      .read(RequestNotifier.provider(user)
                                          .notifier)
                                      .isLoading = true;
                                  ref
                                      .read(
                                          HomeNotifier.provider(user).notifier)
                                      .toggleIsApproved();
                                },
                                isChecked: provider.isApproved,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 16),
                            child: RequestList(
                              user: user,
                              isApproved: provider.isApproved,
                              dateFrom: provider.dateFrom,
                              dateTo: provider.dateTo,
                              dtlId: provider.dtlId,
                            )),
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

List<Request> requestsDummy = [
  Request(DateTime(2022, 09, 16, 16, 47, 44))
    ..id = 33
    ..submitUserName = "admin"
    ..submitFullName = ""
    ..documentName = "testduyetgc2"
    ..approvalStage = "1"
    ..opinion = "OK "
    ..emergency = false
    ..isApproved = true
    ..finished = true,
  Request(DateTime(2022, 09, 16, 16, 47, 44))
    ..id = 33
    ..submitUserName = "admin"
    ..submitFullName = ""
    ..documentName = "testduyetgc2"
    ..approvalStage = "1"
    ..opinion = "OK "
    ..emergency = false
    ..isApproved = true
    ..finished = true,
];
