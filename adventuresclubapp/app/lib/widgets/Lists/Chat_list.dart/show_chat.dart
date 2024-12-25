import 'dart:developer';

import 'package:app/constants.dart';
import 'package:app/widgets/null_user_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../new_signup/new_register.dart';
import '../../../sign_up/sign_in.dart';
import '../../buttons/button.dart';
import '../../my_text.dart';

class ShowChat extends StatefulWidget {
  final String url;
  final bool? show;
  final bool? appbar;
  const ShowChat(this.url, {this.show = false, this.appbar = true, super.key});

  @override
  State<ShowChat> createState() => _ShowChatState();
}

class _ShowChatState extends State<ShowChat> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const CircularProgressIndicator();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            log(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void navLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SignIn();
    }));
  }

  void navRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  void showError() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: ListTile(
                tileColor: Colors.transparent,
                //onTap: showCamera,
                leading: const Icon(
                  Icons.notification_important,
                  size: 42,
                  color: redColor,
                ),
                title: MyText(
                  text: "You Are Not logged In",
                  color: Colors.black,
                  weight: FontWeight.w600,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              actions: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                        "login".tr(),
                        //'Register',
                        greenishColor,
                        greenishColor,
                        whiteColor,
                        20,
                        navLogin,
                        Icons.add,
                        whiteColor,
                        false,
                        2,
                        'Raleway',
                        FontWeight.w600,
                        18),
                    Container(
                      color: transparentColor,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "dontHaveAnAccount?".tr(),
                                    style: const TextStyle(
                                        color: bluishColor, fontSize: 16)),
                                // TextSpan(
                                //   text: "register".tr(),
                                //   style: const TextStyle(
                                //       fontWeight: FontWeight.bold, color: whiteColor),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Button(
                          "register".tr(),
                          greenishColor,
                          greenishColor,
                          whiteColor,
                          20,
                          navRegister,
                          Icons.add,
                          whiteColor,
                          false,
                          2,
                          'Raleway',
                          FontWeight.w600,
                          20),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appbar == true
            ? AppBar(
                backgroundColor: whiteColor,
                iconTheme: const IconThemeData(color: blackColor),
                title: widget.show!
                    ? MyText(
                        text: 'Bank Infomation',
                        color: blackColor,
                        weight: FontWeight.bold,
                      )
                    : MyText(
                        text: 'chat'.tr(),
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                centerTitle: true,
              )
            : null,
        body: Constants.userId > 0
            ? WebViewWidget(controller: controller)
            : const NullUserContainer());
  }
}
