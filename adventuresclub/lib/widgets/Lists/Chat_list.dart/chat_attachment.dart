// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// class ChatAttachment extends StatefulWidget {
//   final String url;
//   const ChatAttachment(this.url, {super.key});

//   @override
//   State<ChatAttachment> createState() => _ChatAttachmentState();
// }

// class _ChatAttachmentState extends State<ChatAttachment> {
//   final Set<JavascriptChannel> jsChannels = [
//     JavascriptChannel(
//         name: 'Print',
//         onMessageReceived: (JavascriptMessage message) {
//           print(message.message);
//         }),
//   ].toSet();

//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: widget.url,
//       javascriptChannels: jsChannels,
//       mediaPlaybackRequiresUserGesture: false,
//       appBar: AppBar(
//         title: const Text('Chat'),
//       ),
//       withZoom: true,
//       withLocalStorage: true,
//       hidden: true,
//       // initialChild: Container(
//       //   color: Colors.redAccent,
//       //   child: const Center(
//       //     child: Text('Waiting.....'),
//       //   ),
//       // ),
//     );
//   }
// }
