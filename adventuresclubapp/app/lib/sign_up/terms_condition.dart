// // ignore_for_file: avoid_function_literals_in_foreach_calls

// import 'dart:convert';
// import 'package:app/constants.dart';
// import 'package:app/widgets/my_text.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/terms_conditition_mode.dart';

// class TermsConditions extends StatefulWidget {
//   const TermsConditions({super.key});

//   @override
//   State<TermsConditions> createState() => _TermsConditionsState();
// }

// class _TermsConditionsState extends State<TermsConditions> {
//   Map MapFilter = {};
//   List<TermsConditionModel> termsList = [];
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     getTerms();
//   }

//   Future getTerms() async {
//     setState(() {
//       loading = true;
//     });
//     var response = await http
//         .get(Uri.parse("${Constants.baseUrl}/api/v1/terms-conditions"));
//     if (response.statusCode == 200) {
//       MapFilter = json.decode(response.body);
//       List<dynamic> result = MapFilter['data'];
//       result.forEach((element) {
//         int id = int.tryParse(element['id'].toString()) ?? 0;
//         TermsConditionModel tc = TermsConditionModel(
//           id: id,
//           title: element['title'].toString() ?? "",
//           titleAr: element['title_ar'].toString() ?? "",
//           description: element['description'].toString() ?? "",
//           descriptionAr: element['description_ar'].toString() ?? "",
//           ca: element['created_at'].toString() ?? "",
//           ua: element['updated_at'].toString() ?? "",
//           da: element['deleted_at'].toString() ?? "",
//         );
//         termsList.add(tc);
//       });
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: MyText(
//             text: "termsAndConditions",
//             weight: FontWeight.bold,
//             color: bluishColor,
//           ),
//           iconTheme: const IconThemeData(color: blackColor),
//           backgroundColor: Colors.white,
//         ),
//         body: loading
//             ? MyText(text: "Loading...")
//             : ListView.builder(
//                 itemCount: termsList.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (termsList[index].title != "null" &&
//                             termsList[index].titleAr != "null" &&
//                             termsList[index].title.isNotEmpty &&
//                             termsList[index].titleAr.isNotEmpty)
//                           Constants.language == "en"
//                               ? MyText(
//                                   text: termsList[index].title, //"Text 1",
//                                   weight: FontWeight.bold,
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 )
//                               : MyText(
//                                   text: termsList[index].titleAr, //"Text 1",
//                                   weight: FontWeight.bold,
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         if (termsList[index].descriptionAr != "null" &&
//                             termsList[index].description != "null" &&
//                             termsList[index].description.isNotEmpty &&
//                             termsList[index].descriptionAr.isNotEmpty)
//                           Constants.language == "en"
//                               ? MyText(
//                                   text:
//                                       termsList[index].description, //"Text 2",
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 )
//                               : MyText(
//                                   text: termsList[index]
//                                       .descriptionAr, //"Text 2",
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 ),
//                         const Divider(
//                           thickness: 1,
//                           color: greyProfileColor,
//                         ),
//                       ],
//                     ),
//                   );
//                 }));
//   }
// }

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/terms_conditition_mode.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  Map MapFilter = {};
  List<TermsConditionModel> termsList = [];
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    getTerms();
  }

  Future getTerms() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      var response = await http
          .get(Uri.parse("${Constants.baseUrl}/api/v1/terms-conditions"));

      if (response.statusCode == 200) {
        MapFilter = json.decode(response.body);
        List<dynamic> result = MapFilter['data'];
        setState(() {
          termsList.clear(); // Clear existing list
        });

        result.forEach((element) {
          int id = int.tryParse(element['id'].toString()) ?? 0;
          TermsConditionModel tc = TermsConditionModel(
            id: id,
            title: element['title'].toString() ?? "",
            titleAr: element['title_ar'].toString() ?? "",
            description: element['description'].toString() ?? "",
            descriptionAr: element['description_ar'].toString() ?? "",
            ca: element['created_at'].toString() ?? "",
            ua: element['updated_at'].toString() ?? "",
            da: element['deleted_at'].toString() ?? "",
          );
          termsList.add(tc);
        });

        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load terms: ${response.statusCode}';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Partnership contract terms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (loading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.teal,
              strokeWidth: 2.5,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading Terms',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: getTerms,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Column(
        children: [
          // Terms List
          ...termsList.map((term) => _buildTermCard(term)).toList(),
        ],
      ),
    );
  }

  Widget _buildTermCard(TermsConditionModel term) {
    // Skip empty/null content
    if ((term.title == "null" || term.title.isEmpty) &&
        (term.titleAr == "null" || term.titleAr.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Constants.language == "en"
            ? Text(
                term.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              )
            : Text(
                term.titleAr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
        trailing: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.teal[700],
        ),
        children: [
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Constants.language == "en"
                ? Text(
                    term.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[900],
                      height: 1.6,
                    ),
                  )
                : Text(
                    term.descriptionAr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[900],
                      height: 1.6,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
