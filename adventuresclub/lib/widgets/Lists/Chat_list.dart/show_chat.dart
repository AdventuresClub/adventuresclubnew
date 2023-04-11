import 'dart:developer';

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../my_text.dart';

class ShowChat extends StatefulWidget {
  final String url;
  final bool? show;
  const ShowChat(this.url, {this.show = false, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(color: blackColor),
        title: widget.show!
            ? MyText(
                text: 'Bank Infomation',
                color: blackColor,
                weight: FontWeight.bold,
              )
            : MyText(
                text: 'Chat',
                color: blackColor,
                weight: FontWeight.bold,
              ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
