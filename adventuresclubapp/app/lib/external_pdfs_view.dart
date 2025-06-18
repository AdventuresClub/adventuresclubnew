import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExternalPdfsView extends StatefulWidget {
  final String url;
  const ExternalPdfsView({required this.url, super.key});

  @override
  State<ExternalPdfsView> createState() => _ExternalPdfsViewState();
}

class _ExternalPdfsViewState extends State<ExternalPdfsView> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> createPDF() async {
    final pdf = await rootBundle.load('assets/translations/partnership.pdf');
    return pdf.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partnerships"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : PdfPreview(
              allowPrinting: true,
              loadingWidget: const CircularProgressIndicator(),
              canChangeOrientation: false,
              canChangePageFormat: false,
              canDebug: false,
              allowSharing: true,
              build: (format) => createPDF(),
            ),
    );
  }
}
