import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:printing/printing.dart' as printing;
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
    ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  UserProfileModel profile = UserProfileModel(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      ProfileBecomePartner(0, 0, "", "", "", "", "", "", "", "", 0, 0, "", "",
          "", "", "", "", "", 0, "", "", "", "", "", ""));

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

  // activitiesImages.add(
  //     "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.activityIncludes[i].image}");

  Future<Uint8List> createPDF() async {
    List<Uint8List> activitiesImages = [];
    final pw.Font arabicFont = await PdfGoogleFonts.notoNaskhArabicRegular();
    final pw.Font arabicFontBold = await PdfGoogleFonts.notoNaskhArabicBold();
    for (int i = 0; i < widget.sm.activityIncludes.length; i++) {
      final http.Response responseActivityImage = await http.get(Uri.parse(
          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.activityIncludes[i].image}"));
      final Uint8List networkImage = responseActivityImage.bodyBytes;
      final Uint8List aImage = networkImage.buffer.asUint8List();
      activitiesImages.add(aImage);
    }
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
    var images = [];
    var audienceImages = [];
    var dependencyImage = [];
    for (int i = 0; i < widget.sm.activityIncludes.length; i++) {
      final netImage = await printing.networkImage(
          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.activityIncludes[i].image}");
      images.add(netImage);
    }
    for (int z = 0; z < widget.sm.am.length; z++) {
      final netImage = await printing.networkImage(
          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.am[z].image}");
      audienceImages.add(netImage);
    }
    for (int a = 0; a < widget.sm.dependency.length; a++) {
      final netImage = await printing.networkImage(
          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.sm.dependency[a].name}");
      dependencyImage.add(netImage);
    }
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.standard,
          theme: pw.ThemeData.withFont(
            base: arabicFont,
            bold: arabicFontBold,
          ),
          margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          // header: contentHeader,
          build: ((pw.Context ctx) => [
                contentBody(ctx, logoImage, serviceImage, ss, st, sl, images,
                    audienceImages, dependencyImage)
              ])),
    );
    return pdf.save();
  }

  Uint8List concatenateUint8List(List<Uint8List> list) {
    final totalLength = list.fold(0, (sum, item) => sum + item.length);
    final Uint8List result = Uint8List(totalLength);
    int offset = 0;

    for (var data in list) {
      result.setRange(offset, offset + data.length, data);
      offset += data.length;
    }

    return result;
  }

  pw.Widget contentBody(pw.Context ctx, qrCode, sImage, ssImage, stImage,
      slImage, aImage, audienceImage, dependencyImage) {
    //final List<dynamic> a = [];
    final imageBytes = qrCode.buffer.asUint8List();
    final sBytes = sImage.buffer.asUint8List();
    final ssBytes = ssImage.buffer.asUint8List();
    final stBytes = stImage.buffer.asUint8List();
    final slBytes = slImage.buffer.asUint8List();
    // for (int i = 0; i < aaImages.length; i++) {

    // }

    final image = pw.MemoryImage(imageBytes);
    final serviceImage = pw.MemoryImage(sBytes);
    final ss = pw.MemoryImage(ssBytes);
    final st = pw.MemoryImage(stBytes);
    final sl = pw.MemoryImage(slBytes);
    // List<pw.MemoryImage> activitiesImages = [];
    // for (int j = 0; j < aImage.length; j++) {
    //   final sImageData = aImage[j].buffer.asUint8List();
    //   //final sid = pw.MemoryImage(sImageData);
    //   activitiesImages.add(sImageData);
    // }
    // List<Uint8List> aImages = aaImages; // Your list of Uint8List images

// List<pw.MemoryImage> activitiesImages = aImages.map((Uint8List imageData) {
//   return pw.MemoryImage(imageData); // No need to call asUint8List, it's already Uint8List
// }).toList();
    // List<pw.MemoryImage> activitiesImages = aaImages.map((imageData) {
    //   final sImageData = imageData.buffer.asUint8List();
    //   return pw.MemoryImage(sImageData); // No need for .buffer.asUint8List()
    // }).toList();
    // List<pw.MemoryImage> activitiesImages =
    //     aaImages.map<pw.MemoryImage>((Uint8List imageData) {

    //   return pw.MemoryImage(imageData);
    // }).toList();
    pw.TextDirection textDirection = context.locale.languageCode == 'ar'
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        // pw.SizedBox(height: 5),
        // pw.Text(widget.sm.adventureName,
        //     style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        //pw.SizedBox(height: 2),
        pw.Center(
          child:
              pw.Image(image, width: 1000, height: 300, fit: pw.BoxFit.contain),
        ),
        pw.SizedBox(
          height: 20,
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround, children: [
          pw.Column(children: [
            pw.Image(
              serviceImage,
              width: 100,
              height: 80,
            ),
            pw.SizedBox(height: 10),
            pw.Text(widget.sm.serviceCategory,
                style: const pw.TextStyle(fontSize: 22))
          ]),
          pw.Column(children: [
            pw.Image(
              ss,
              width: 100,
              height: 80,
            ),
            pw.SizedBox(height: 10),
            pw.Text(widget.sm.serviceSector,
                style: const pw.TextStyle(fontSize: 22))
          ]),
          pw.Column(children: [
            pw.Image(
              st,
              width: 100,
              height: 80,
            ),
            pw.SizedBox(height: 10),
            pw.Text(widget.sm.serviceType,
                style: const pw.TextStyle(fontSize: 22))
          ]),
          pw.Column(children: [
            pw.Image(
              sl,
              width: 100,
              height: 80,
            ),
            pw.SizedBox(height: 5),
            pw.Text(widget.sm.serviceLevel,
                style: const pw.TextStyle(fontSize: 22))
          ])
        ]),
        pw.SizedBox(height: 20),
        pw.Text(
          widget.sm.adventureName,
          style: pw.TextStyle(
            fontSize: 28,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        // pw.Text(
        //   widget.sm.region,
        //   style: const pw.TextStyle(
        //     fontSize: 28,
        //     //fontWeight: pw.FontWeight.bold,
        //   ),
        // ),
        pw.Text(
          "${widget.sm.country} ${widget.sm.region}",
          style: const pw.TextStyle(
            fontSize: 22,
            //fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(thickness: 1),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround, children: [
          pw.Column(children: [
            pw.Text(
              "${widget.sm.currency}  ${widget.sm.costInc}",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                //color:Colors.blueAccent, //bluishColor,
                color: const PdfColor.fromInt(0xFF1C3947),
                fontSize: 22,
              ),
            ),
            pw.Text("Including gears & taxes",
                style: const pw.TextStyle(
                  fontSize: 18,
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
                fontSize: 22,
              ),
            ),
            pw.Text("Excluding gears & taxes",
                style: const pw.TextStyle(
                  fontSize: 18,
                  color: PdfColor.fromInt(0xFFDF5252),
                ))
          ]),
        ]),
        if (widget.sm.sPlan == 2)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("${"Start Date : "} $sDate",
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text("${"End Date : "} $ed",
                  style: const pw.TextStyle(fontSize: 18))
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
        pw.SizedBox(height: 5),
        pw.Text(
          "Description",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          widget.sm.writeInformation,
          style: const pw.TextStyle(
            fontSize: 16,
            //fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 20),
        pw.Text(
          "Activities Includded",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Wrap(
          children: [
            for (int j = 0; j < aImage.length; j++)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                child: pw.Column(
                  children: [
                    pw.Image(
                      aImage[j],
                      height: 40,
                      width: 40,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      widget.sm.activityIncludes[j].activity,
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
        pw.Divider(thickness: 1),
        pw.Text(
          "Audience",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        // pw.SizedBox(height: 20),
        pw.Wrap(
          children: [
            for (int j = 0; j < audienceImage.length; j++)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                child: pw.Column(
                  children: [
                    pw.Image(
                      audienceImage[j],
                      height: 40,
                      width: 40,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      widget.sm.am[j].aimedName,
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ],
                ),
              )
          ],
        ),

        pw.Divider(thickness: 1),
        pw.Text(
          "Dependency",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Wrap(
          children: [
            for (int j = 0; j < dependencyImage.length; j++)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                child: pw.Column(
                  children: [
                    pw.Image(
                      dependencyImage[j],
                      height: 40,
                      width: 40,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      widget.sm.dependency[j].dName,
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ],
                ),
              )
          ],
        ),
        pw.Divider(thickness: 1),
        pw.Text(
          "Activity Program",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        if (widget.sm.sPlan == 1) pw.Text(widget.sm.sPlan.toString()),
        if (widget.sm.sPlan == 2)
          pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
              child: pw.Column(children: [
                for (int i = 0; i < widget.sm.programmes.length; i++)
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 80,
                          height: 80,
                          decoration: pw.BoxDecoration(
                              color: const PdfColor.fromInt(0xFF1C3947),
                              borderRadius: pw.BorderRadius.circular(46)),
                          child: pw.Center(
                            child: pw.Text(
                              (i + 1).toString(),
                              style: pw.TextStyle(
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold,
                                color: const PdfColor.fromInt(0xFFE4E9F8),
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 25),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                  "${widget.sm.programmes[i].title} ${startDate.day}-${startDate.year}",
                                  style: pw.TextStyle(
                                      fontSize: 22,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text("${widget.sm.programmes[i].des}",
                                  style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xFF979797),
                                      fontSize: 22,
                                      fontWeight: pw.FontWeight.bold))
                            ])
                      ])
              ])),
        // pw.SizedBox(
        //   width: PdfPageFormat.inch * 3,
        //   child: pw.Column(
        //     crossAxisAlignment: pw.CrossAxisAlignment.start,
        //     children: [
        //       pw.Text(
        //         "${"Location"}",
        //         style: pw.TextStyle(
        //           fontSize: 10,
        //           fontWeight: pw.FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // if (widget.inspection != null && widget.inspection!.status == "closed")
        // pw.Column(children: [

        //   pw.Row(
        //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //     children: [],
        //   ),
        // ]),
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 20),
        pw.Text(
          "Pre Requisites",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          widget.sm.preRequisites,
          style: const pw.TextStyle(
            fontSize: 16,
            //fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 10),
        pw.Text(
          "Minimum Requirements",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          widget.sm.mRequirements,
          style: const pw.TextStyle(
            fontSize: 16,
            //fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 10),
        pw.Text(
          "Terms & Conditions",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          widget.sm.tnc,
          style: const pw.TextStyle(
            fontSize: 16,
            //fontWeight: pw.FontWeight.bold,
          ),
        ),
         pw.Divider(thickness: 1),
         pw.SizedBox(height: 10),
        pw.Text(
          "Provided By",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          "Provided By",
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

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
                // minScale: 1,
                // maxScale: 3,
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
