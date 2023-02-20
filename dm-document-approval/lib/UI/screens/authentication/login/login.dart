// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/components/vietsoft_bottom_bar.dart';
import 'package:viet_soft/UI/components/vietsoft_checkbox.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';
import 'package:viet_soft/UI/screens/authentication/login/components/login_button.dart';
import 'package:viet_soft/UI/screens/authentication/login/components/login_textfield.dart';
import 'package:viet_soft/UI/screens/home/home_screen.dart';
import 'package:viet_soft/UI/screens/update/update_screen.dart';
import 'package:viet_soft/logic/models/base_url.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/login_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:localstorage/localstorage.dart';

import '../../../../repositories/home_repository.dart';

class Login extends ConsumerWidget {
  Login({Key? key, this.userId, this.requestId, this.listTemp})
      : super(key: key);
  final int? userId;
  final int? requestId;
  List<String>? listTemp;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(LoginNotifier.provider);
    double radius = 55;
    // getCbo(ref);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: const VietSoftBottomBar(),
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              color: VietSoftColor.backgroundGreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: VietSoftSize.getSize(209, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.settings,
                              color: VietSoftColor.backgroundGreen,
                            )),
                        Image.asset(
                          "assets/logo/logo_vietsoft.png",
                          width: VietSoftSize.getSize(719, context),
                          height: VietSoftSize.getSize(719, context),
                        ),
                        IconButton(
                            onPressed: () {
                              inputHostName(context, provider, ref);
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: VietSoftSize.getSize(146, context),
                      bottom: VietSoftSize.getSize(1227 - 1074 - 80, context),
                    ),
                    child: Text(
                      ResString.welcomeBack,
                      style: TextStyle(
                          fontSize: VietSoftSize.getSize(79.37, context),
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    ResString.logInNow,
                    style: TextStyle(
                        fontSize: VietSoftSize.getSize(106.43, context),
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin:
                    EdgeInsets.only(top: VietSoftSize.getSize(1527, context)),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: VietSoftSize.getSize(100, context),
                            bottom: VietSoftSize.getSize(93, context)),
                        child: LoginTextField(
                          key: Key(provider.userName),
                          hintText: ResString.inputEmployeeIdentify,
                          initialValue: provider.userName,
                          onChanged: (value) {
                            ref
                                .read(LoginNotifier.provider.notifier)
                                .setUserName(value);
                          },
                        ),
                      ),
                      LoginTextField(
                        key: Key(provider.password),
                        hintText: ResString.inputPassword,
                        initialValue: provider.password,
                        onChanged: (value) {
                          ref
                              .read(LoginNotifier.provider.notifier)
                              .setPassword(value);
                        },
                        obscureText: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: VietSoftSize.getSize(137, context),
                            horizontal: 16),
                        child: Row(
                          children: [
                            VietSoftCheckBox(
                              onTap: () {
                                ref
                                    .watch(LoginNotifier.provider.notifier)
                                    .toggleSavePassword();
                              },
                              isChecked: provider.savePassword,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                ResString.savePassword,
                                style: TextStyle(
                                    fontSize:
                                        VietSoftSize.getSize(79.37, context),
                                    color: VietSoftColor.loginTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LoginButton(
                        buttonTitle: ResString.logIn,
                        darkBtnColor: VietSoftColor.darkBackgroundGreen,
                        lightBtColor: VietSoftColor.lightBackgroundGreen,
                        onTap: () {
                          String baseURL = ref
                                  .read(LoginNotifier.provider.notifier)
                                  .service
                                  .networkService
                                  .baseUrl
                                  ?.domain ??
                              "";
                          if (baseURL.isEmpty) {
                            inputHostName(context, provider, ref);
                          } else {
                            onLogin(context, ref);
                          }
                        },
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: VietSoftSize.getSize(112, context),
                      //       horizontal: 12),
                      //   child: const Divider(
                      //     height: 0,
                      //     thickness: 1,
                      //     color: VietSoftColor.loginTextColor,
                      //   ),
                      // ),
                      // LoginButton(
                      //   buttonTitle: ResString.changePassword,
                      //   darkBtnColor: VietSoftColor.darkLoginTextColor,
                      //   lightBtColor: VietSoftColor.lightLoginTextColor,
                      //   onTap: (() {}),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: VietSoftSize.getSize(
                      //           3903 - 3502 - 322, context),
                      //       bottom: 26),
                      //   child: const TextLink(
                      //     title: ResString.forgotPassword,
                      //     color: VietSoftColor.loginTextColor,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Future<void> getCbo(WidgetRef ref) async {
    listTemp =
        await ref.read(LoginNotifier.provider.notifier).getComboDatabase();
  }

  // (ref
  //                   .read(LoginNotifier.provider.notifier)
  //                   .service
  //                   .networkService
  //                   .baseUrl
  //                   ?.domain ??
  //               "") !=
  //           ""
  //       ? listTemp =
  //           await ref.read(LoginNotifier.provider.notifier).getComboDatabase()
  //       : listTemp;

  Future<void> inputHostName(
      BuildContext context, LoginState provider, WidgetRef ref) async {
    final LocalStorage storage = new LocalStorage('localstorage_app');
    CrossPlatform.showBottomSheet(context,
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: LoginTextField(
                  initialValue: ref
                          .read(LoginNotifier.provider.notifier)
                          .service
                          .networkService
                          .baseUrl
                          ?.domain ??
                      "",
                  hintText: "Nhập host name",
                  onChanged: (value) {
                    ref.read(LoginNotifier.provider.notifier).setBaseUrl(value);
                    // getCbo(ref);
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: FilterDropdownTest(key, listTemp, ref),
              // ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: LoginButton(
                      buttonTitle: "Cập nhật",
                      darkBtnColor: VietSoftColor.darkBackgroundGreen,
                      lightBtColor: VietSoftColor.lightBackgroundGreen,
                      onTap: () async {
                        ref
                            .read(LoginNotifier.provider.notifier)
                            .service
                            .networkService
                            .baseUrl = BaseUrl(provider.baseUrl);
                        ref
                            .read(LoginNotifier.provider.notifier)
                            .service
                            .networkService
                            .saveLoginInfor(value: provider.baseUrl);

                        await storage.ready;
                        storage.setItem(
                            'dbname',
                            (ref.watch(LoginNotifier.provider).nameDatabase)
                                .toString()
                                .trim());
                        // ref
                        //     .read(LoginNotifier.provider.notifier)
                        //     .service
                        //     .networkService
                        //     .saveDBName(
                        //         ref.watch(LoginNotifier.provider).nameDatabase);
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
                    child: LoginButton(
                      buttonTitle: "Home",
                      darkBtnColor: VietSoftColor.darkLoginTextColor,
                      lightBtColor: VietSoftColor.lightLoginTextColor,
                      onTap: () {
                        print(provider.baseUrl);
                        ref
                            .read(LoginNotifier.provider.notifier)
                            .service
                            .networkService
                            .baseUrl = BaseUrl(provider.baseUrl);
                        ref
                            .read(LoginNotifier.provider.notifier)
                            .service
                            .networkService
                            .saveLoginInfor(value: provider.baseUrl);
                        CrossPlatform.backTransitionPage(context);
                        onLogin(context, ref);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void onLogin(BuildContext context, WidgetRef ref) async {
    try {
      CrossPlatform.showLoadingAlert(context, "Đang Đăng Nhập", true);
      User user = await ref.read(LoginNotifier.provider.notifier).login();
      LoginNotifier loginNotifier = ref.read(LoginNotifier.provider.notifier);
      if (userId != null) {
        if (userId == user.userId) {
          CrossPlatform.transitionToPage(
              context,
              UpdateScreen(
                requestId: requestId!,
                user: user,
                isOpenFromNoti: true,
              ),
              newPage: true);
        } else {
          CrossPlatform.showErrorSnackbar(
              context, "Đăng nhập không đúng tài khoản nhận thông báo!");
        }
      } else {
        if (loginNotifier.userId != null) {
          if (loginNotifier.userId == user.userId) {
            CrossPlatform.transitionToPage(
                context,
                UpdateScreen(
                  requestId: loginNotifier.requestId!,
                  user: user,
                  isOpenFromNoti: true,
                ),
                newPage: true);
          } else {
            CrossPlatform.showErrorSnackbar(
                context, "Đăng nhập không đúng tài khoản nhận thông báo!");
          }
        } else {
          CrossPlatform.backTransitionPage(context);
          CrossPlatform.pushAndRemoveAll(
            context,
            HomeScreen(user: user),
          );
        }
      }
    } catch (e) {
      CrossPlatform.backTransitionPage(context);
      CrossPlatform.showErrorSnackbar(context, "Đăng nhập thất bại");
    }
  }
}
