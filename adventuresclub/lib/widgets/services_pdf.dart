import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class ServicesPdf extends StatefulWidget {
  final ServicesModel sm;
  const ServicesPdf({required this.sm, super.key});

  @override
  State<ServicesPdf> createState() => _ServicesPdfState();
}

class _ServicesPdfState extends State<ServicesPdf> {
  bool loading = false;
  String aPlan = "";
  List<String> adventuresPlan = [""];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String sDate = "";
  String ed = "";
  List<String> activityImages = [];
  List<MemoryImage> activitiesIncluded = [];

  @override
  void initState() {
    super.initState();
    if (widget.sm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.sm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMM').format(startDate);
      sDate = "${startDate.day}-$sMonth-${startDate.year}";
      endDate =
          DateTime.tryParse(widget.sm.availability[0].ed) ?? DateTime.now();
      String eMonth = DateFormat('MMM').format(startDate);
      ed = "${endDate.day}-$eMonth-${endDate.year}";
    }
    getSteps();
  }

  void getSteps() {
    for (var element in widget.sm.availabilityPlan) {
      adventuresPlan.add(element.day.tr());
    }
    aPlan = adventuresPlan.join(", ");
  }

  Future<Uint8List> createPDF() async {
    final pw.Font arabicFont = await PdfGoogleFonts.notoNaskhArabicRegular();
    final pw.Font arabicFontBold = await PdfGoogleFonts.notoNaskhArabicBold();
    String image =
        "${"${Constants.baseUrl}/public/uploads/"}${widget.sm.images[0].imageUrl}";
    String serviceCategory =
        "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.serviceCategoryImage}";
    String serviceSector =
        "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.serviceSectorImage}";
    String serviceTypeImage =
        "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.serviceTypeImage}";
    String serviceLevelImage =
        "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.serviceLevelImage}";

    final http.Response response = await http.get(Uri.parse(image));
    final http.Response response1 = await http.get(Uri.parse(serviceCategory));
    final http.Response response2 = await http.get(Uri.parse(serviceSector));
    final http.Response response3 = await http.get(Uri.parse(serviceTypeImage));
    final http.Response response4 =
        await http.get(Uri.parse(serviceLevelImage));
    //final img = await rootBundle.load('images/logo.png'); //.loadString(image);
    final Uint8List networkImage = response.bodyBytes;
    final Uint8List serviceC = response1.bodyBytes;
    final Uint8List serviceS = response2.bodyBytes;
    final Uint8List serviceT = response3.bodyBytes;
    final Uint8List serviceL = response4.bodyBytes;

    // Load the local image (logo)
    //final ByteData logoData = await rootBundle.load('images/logo.png');
    final Uint8List logoImage = networkImage.buffer.asUint8List();
    final Uint8List serviceImage = serviceC.buffer.asUint8List();
    final Uint8List ss = serviceS.buffer.asUint8List();
    final Uint8List st = serviceT.buffer.asUint8List();
    final Uint8List sl = serviceL.buffer.asUint8List();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.standard,
          theme: pw.ThemeData.withFont(
            base: arabicFont,
            bold: arabicFontBold,
          ),
          margin: const pw.EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          // header: contentHeader,
          build: ((pw.Context ctx) {
            return contentBody(ctx, logoImage, serviceImage, ss, st, sl);
          })),
    );
    return pdf.save();
  }

  pw.Table getInspection() {
    const tableHeaders = [
      'Item Name',
      'Description',
      //'Labour',
      'Qty',
      'price',
      'Sub Total',
    ];
    return pw.TableHelper.fromTextArray(
      columnWidths: const {
        0: pw.FlexColumnWidth(2),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
        4: pw.FlexColumnWidth(1.5),
        5: pw.FlexColumnWidth(1.5),
      },
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerHeight: 0,
      headerDecoration: pw.BoxDecoration(
        color: PdfColors.grey400,
        border: pw.Border.all(
          color: PdfColors.black,
          width: 1,
        ),
      ),
      headerStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 6,
      ),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
      },
      cellDecoration: (index, data, rowNum) {
        return pw.BoxDecoration(
          color: PdfColors.white,
          border: pw.Border.all(
            color: PdfColors.black,
            width: 1,
          ),
        );
      },
      cellStyle: const pw.TextStyle(fontSize: 8),
      tableDirection: pw.TextDirection.rtl,
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.grey,
            width: .1,
          ),
        ),
      ),
      headers: List<String>.generate(
          tableHeaders.length, (col) => tableHeaders[col]),
      data: getInspectionTableData(),
    );
  }

  List<List<String>> getInspectionTableData() {
    List<List<String>> itemsForTable = [];
    itemsForTable.add([
      "",
      "",
      //package!.labour.toString(),
      "1",
      "",
      "",
    ]);
    return itemsForTable;
  }

  pw.Widget contentBody(
      pw.Context ctx, qrCode, sImage, ssImage, stImage, slImage) {
    final imageBytes = qrCode.buffer.asUint8List();
    final sBytes = sImage.buffer.asUint8List();
    final ssBytes = ssImage.buffer.asUint8List();
    final stBytes = stImage.buffer.asUint8List();
    final slBytes = slImage.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);
    final serviceImage = pw.MemoryImage(sBytes);
    final ss = pw.MemoryImage(ssBytes);
    final st = pw.MemoryImage(stBytes);
    final sl = pw.MemoryImage(slBytes);
    pw.TextDirection textDirection = context.locale.languageCode == 'ar'
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        // pw.SizedBox(height: 5),
        // pw.Text(widget.sm.adventureName,
        //     style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        //pw.SizedBox(height: 2),
        pw.Image(image, width: 800, height: 300, fit: pw.BoxFit.contain),
        pw.SizedBox(
          height: 20,
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Column(children: [
                    pw.Image(
                      serviceImage,
                      width: 100,
                      height: 100,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(widget.sm.serviceCategory,
                        style: const pw.TextStyle(fontSize: 22))
                  ]),
                  pw.Column(children: [
                    pw.Image(
                      ss,
                      width: 100,
                      height: 100,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(widget.sm.serviceSector,
                        style: const pw.TextStyle(fontSize: 22))
                  ]),
                  pw.Column(children: [
                    pw.Image(
                      st,
                      width: 100,
                      height: 100,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(widget.sm.serviceType,
                        style: const pw.TextStyle(fontSize: 22))
                  ]),
                  pw.Column(children: [
                    pw.Image(
                      sl,
                      width: 100,
                      height: 100,
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(widget.sm.serviceLevel,
                        style: const pw.TextStyle(fontSize: 22))
                  ])
                ]),
            pw.SizedBox(height: 10),
            pw.Text(
              widget.sm.adventureName,
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "${widget.sm.country} ${widget.sm.region}",
              style: const pw.TextStyle(
                fontSize: 14,
                //fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Divider(thickness: 1),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Column(children: [
                    pw.Text(
                      "${widget.sm.currency}  ${widget.sm.costInc}",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        //color:Colors.blueAccent, //bluishColor,
                        color: const PdfColor.fromInt(0xFF1C3947),
                        fontSize: 14,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text("Including gears & taxes",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColor.fromInt(0xFFDF5252),
                        ))
                  ]),
                  pw.Container(
                    color: const PdfColor.fromInt(0xff000000),
                    width: 0.01,
                    height: 45,
                  ),
                  pw.Column(children: [
                    pw.Text(
                      "${widget.sm.currency}  ${widget.sm.costExc}",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xFF1C3947),
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text("Excluding gears & taxes",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColor.fromInt(0xFFDF5252),
                        ))
                  ]),
                ]),
            if (widget.sm.sPlan == 2)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("${"Start Date : "} $sDate",
                      style: const pw.TextStyle(fontSize: 8)),
                  pw.Text("${"End Date : "} $ed",
                      style: const pw.TextStyle(fontSize: 8))
                ],
              ),
            if (widget.sm.sPlan == 1)
              pw.RichText(
                text: pw.TextSpan(
                  text: 'Availability'.tr(),
                  style: pw.TextStyle(
                    color: const PdfColor.fromInt(0xFF1C3947),
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  children: [
                    pw.TextSpan(
                        text: aPlan,
                        style: const pw.TextStyle(
                          fontSize: 24,
                          //fontWeight: pw.FontWeight.w400,
                        )),
                  ],
                ),
              ),
            pw.Divider(thickness: 1),
            // pw.SizedBox(height: 2),
            pw.Text(
              "Description",
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              widget.sm.writeInformation,
              style: const pw.TextStyle(
                fontSize: 8,
                //fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Divider(thickness: 1),
            // pw.SizedBox(height: 2),
            pw.Text(
              "Activities Includded",
              style: pw.TextStyle(
                fontSize: 10,
                //fontWeight: pw.FontWeight.bold,
              ),
            ),

            // pw.SizedBox(height: 2),
            pw.Text(
              widget.sm.activityIncludes[0].activity,
              style: pw.TextStyle(
                fontSize: 10,
                //fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Divider(thickness: 1),
            //pw.SizedBox(height: 2),
            pw.Text(
              "Audience",
              style: pw.TextStyle(
                fontSize: 10,
                //fontWeight: pw.FontWeight.bold,
              ),
            ),
            // pw.SizedBox(height: 20),
            pw.Text(
              widget.sm.am[0].aimedName,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.Divider(thickness: 1),
            pw.Text(
              "Dependency",
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              width: PdfPageFormat.inch * 3,
              child: pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Text(widget.sm.dependency[0].dName),
                      // pw.SizedBox(
                      //   width: 10,
                      // ),
                      pw.Text(
                        "Activity Program",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        widget.sm.availability[0].st,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(
              width: PdfPageFormat.inch * 3,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "${"Location"}",
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(
              width: PdfPageFormat.inch * 3,
              child: pw.Text(
                "${""}",
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            //pw.Row(children: [pw.Expanded(child: getInspection())])
          ],
        ),
        pw.SizedBox(height: 2),

        pw.Divider(thickness: 0.1),

        // if (widget.inspection != null && widget.inspection!.status == "closed")
        pw.Column(children: [
          pw.Divider(thickness: 1),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ])
      ],
    );
  }

  pw.Widget contentHeader(pw.Context ctx) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Text(
              'Page ${ctx.pageNumber}/${ctx.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        pw.Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adventure Details"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                minScale: 1,
                maxScale: 3,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: PdfPreview(
                    loadingWidget: const CircularProgressIndicator(),
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    canDebug: false,
                    allowSharing: true,
                    build: (format) => createPDF(),
                  ),
                ),
              ),
            ),
    );
  }
}
