import 'package:flutter/material.dart';

class AppLinkPage extends StatefulWidget {
  final String? id;
  final int? sId;
  const AppLinkPage({this.id, this.sId, super.key});

  @override
  State<AppLinkPage> createState() => _AppLinkPageState();
}

class _AppLinkPageState extends State<AppLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Link Page"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("ID"),
            subtitle: Text(widget.id ?? 'N/A'),
          ),
          ListTile(
            title: Text("sID"),
            subtitle: Text(widget.sId?.toString() ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
