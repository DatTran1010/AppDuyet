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
import 'package:viet_soft/UI/screens/history/history_screen.dart';
import 'package:viet_soft/UI/screens/home/home_screen.dart';
import 'package:viet_soft/UI/screens/update/components/agreement_field.dart';
import 'package:viet_soft/UI/screens/update/components/doc_file.dart';
import 'package:viet_soft/UI/screens/update/components/opinion_textfield.dart';
import 'package:viet_soft/UI/screens/update/components/request_info.dart';
import 'package:viet_soft/logic/models/drop_down_nuq.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/upadate_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/handle_error.dart';
import 'package:viet_soft/utils/url_launch_util.dart';

class UpdateScreen extends ConsumerStatefulWidget {
  const UpdateScreen({
    Key? key,
    required this.requestId,
    required this.user,
    this.isOpenFromNoti = false,
  }) : super(key: key);
  final User user;
  final int requestId;

  final bool isOpenFromNoti;

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends ConsumerState<UpdateScreen> {
  List categoryItemlist = [];

  @override
  void initState() {
    ref
        .read(UpdateNotifier.provider(widget.requestId).notifier)
        .getDocument()
        .onError((error, stackTrace) {
      if (widget.isOpenFromNoti) {
        HandleError.handleUnauthNoti(
            context, error, widget.user.userId!, widget.requestId, ref);
      } else {
        HandleError.handleUnauthorized(context, error);
      }
    });
    super.initState();
    getCbo();
  }

  var valueNUQ;

  final GlobalKey<ScaffoldState> _updateScaffoldState =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final documentProvider =
        ref.watch(UpdateNotifier.provider(widget.requestId));

    final updateStateProvider =
        ref.watch(ApprovalNotifier.provider(widget.requestId));

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: _updateScaffoldState,
          bottomNavigationBar: const VietSoftBottomBar(),
          backgroundColor: VietSoftColor.backgroundGreen,
          drawer: VietSoftDrawer(
            user: widget.user,
          ),
          body: SafeArea(
            child: Column(
              children: [
                VietSoftAppBar(
                  onTap: () {
                    _updateScaffoldState.currentState!.openDrawer();
                  },
                  title: ResString.requestApprove,
                  userName: widget.user.userName!,
                  userId: widget.user.userId!,
                ),
                Expanded(
                  child: BodyContainer(
                    topMargin: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: documentProvider != null
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: RequestInfo(
                                    docNum: documentProvider.docNum ?? "",
                                    requestDate: documentProvider.date,
                                    submitName: widget.user.userName!,
                                  ),
                                ),
                                const VietSoftDivider(),
                                OpinonTextField(
                                    readOnly: true,
                                    initialValue:
                                        documentProvider.requestContent ?? "",
                                    title: ResString.requestContent,
                                    hintText: ""),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: VietSoftSize.getSize(112, context)),
                                  child: DocFile(
                                    onTap: () {
                                      if (documentProvider.includedDoc !=
                                          null) {
                                        print(documentProvider.includedDoc);
                                        URLLauchUtil.viewFile(
                                            documentProvider.includedDoc);
                                      }
                                    },
                                  ),
                                ),
                                const VietSoftDivider(),
                                OpinonTextField(
                                  title: ResString.reviewerOpinion,
                                  hintText: ResString.inputReviewerOpinion,
                                  initialValue: updateStateProvider.opinion,
                                  onChange: (value) {
                                    updateStateProvider.opinion = value;
                                  },
                                ),
                                (valueNUQ == null
                                            ? 0
                                            : int.parse(
                                                valueNUQ.id.toString())) !=
                                        0
                                    ? Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            bottom: VietSoftSize.getSize(
                                                50, context)),
                                        child: AgreementField(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      ApprovalNotifier.provider(
                                                              widget.requestId)
                                                          .notifier)
                                                  .toggleApproved();
                                            },
                                            isChecked:
                                                updateStateProvider.isApproved),
                                      ),
                                updateStateProvider.isApproved
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  VietSoftColor.loginTextColor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              valueNUQ = null;
                                            });
                                          },
                                          child:
                                              DropdownButton<DropDownNUQModel>(
                                            isExpanded: true,
                                            value: valueNUQ,
                                            hint: Text(
                                              ResString.nguoiUQ ??
                                                  categoryItemlist[0].name,
                                            ),
                                            elevation: 0,
                                            onChanged: (value) {
                                              setState(() {
                                                valueNUQ = value;
                                              });
                                            },
                                            underline: const SizedBox(width: 1),
                                            items: categoryItemlist.map<
                                                    DropdownMenuItem<
                                                        DropDownNUQModel>>(
                                                (element) {
                                              return DropdownMenuItem<
                                                  DropDownNUQModel>(
                                                value: element,
                                                child: Text(
                                                  element.name ?? '',
                                                  style: const TextStyle(
                                                      color: VietSoftColor
                                                          .loginTextColor),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 1,
                                        child: VietSoftButton(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          radius: 14,
                                          buttonTitle: ResString.history,
                                          darkBtnColor:
                                              VietSoftColor.darkLoginTextColor,
                                          lightBtColor:
                                              VietSoftColor.lightLoginTextColor,
                                          onTap: () {
                                            CrossPlatform.transitionToPage(
                                                context,
                                                HistoryScreen(
                                                  requestId: widget.requestId,
                                                  docNum:
                                                      documentProvider.docNum!,
                                                  user: widget.user,
                                                ));
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          radius: 14,
                                          buttonTitle: ResString.home,
                                          darkBtnColor:
                                              VietSoftColor.darkBackgroundGreen,
                                          lightBtColor: VietSoftColor
                                              .lightBackgroundGreen,
                                          onTap: () {
                                            CrossPlatform.pushAndRemoveAll(
                                                context,
                                                HomeScreen(user: widget.user));
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            radius: 14,
                                            buttonTitle: ResString.update,
                                            darkBtnColor: VietSoftColor
                                                .darkLoginTextColor,
                                            lightBtColor: VietSoftColor
                                                .lightLoginTextColor,
                                            onTap: () {
                                              ref
                                                  .read(
                                                      ApprovalNotifier.provider(
                                                              widget.requestId)
                                                          .notifier)
                                                  .updateApproval(
                                                      widget.requestId,
                                                      widget.user.userName!,
                                                      valueNUQ == null
                                                          ? 0
                                                          : int.parse(valueNUQ
                                                              .id
                                                              .toString()),
                                                      context,
                                                      widget.user);
                                            },
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : const Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator()),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> getCbo() async {
    categoryItemlist = await ref
        .read(UpdateNotifier.provider(widget.requestId).notifier)
        .getComboNUQ(widget.requestId, widget.user.userName);
  }
}
