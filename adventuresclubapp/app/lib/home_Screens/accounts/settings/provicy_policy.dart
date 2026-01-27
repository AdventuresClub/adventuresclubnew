// // ignore_for_file: avoid_function_literals_in_foreach_calls

// import 'dart:convert';
// import 'package:app/constants.dart';
// import 'package:app/models/terms_conditition_mode.dart';
// import 'package:app/widgets/my_text.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PrivacyPolicy extends StatefulWidget {
//   const PrivacyPolicy({super.key});

//   @override
//   State<PrivacyPolicy> createState() => _PrivacyPolicyState();
// }

// class _PrivacyPolicyState extends State<PrivacyPolicy> {
//   Map mapFilter = {};
//   List<TermsConditionModel> privacyList = [];
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     getPolicy();
//   }

//   Future getPolicy() async {
//     setState(() {
//       loading = true;
//     });
//     var response =
//         await http.get(Uri.parse("${Constants.baseUrl}/api/v1/privacy-policy"));
//     if (response.statusCode == 200) {
//       mapFilter = json.decode(response.body);
//       List<dynamic> result = mapFilter['data'];
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
//         privacyList.add(tc);
//       });
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: MyText(
//           text: "privacyPolicy",
//           weight: FontWeight.bold,
//           color: bluishColor,
//         ),
//         iconTheme: const IconThemeData(color: blackColor),
//         backgroundColor: Colors.white,
//       ),
//       body: loading
//           ? MyText(text: "Loading...")
//           : ListView.builder(
//               itemCount: privacyList.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       if (privacyList[index].title != "null" &&
//                           privacyList[index].titleAr != "null" &&
//                           privacyList[index].title.isNotEmpty &&
//                           privacyList[index].titleAr.isNotEmpty)
//                         Constants.language == "en"
//                             ? MyText(
//                                 text: privacyList[index].title, //"Text 1",
//                                 weight: FontWeight.bold,
//                                 size: 14,
//                                 color: blackColor,
//                                 align: TextAlign.justify,
//                               )
//                             : MyText(
//                                 text: privacyList[index].titleAr, //"Text 1",
//                                 weight: FontWeight.bold,
//                                 size: 14,
//                                 color: blackColor,
//                                 align: TextAlign.justify,
//                               ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       if (privacyList[index].descriptionAr != "null" &&
//                           privacyList[index].description != "null" &&
//                           privacyList[index].description.isNotEmpty &&
//                           privacyList[index].descriptionAr.isNotEmpty)
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Constants.language == "en"
//                               ? MyText(
//                                   text: privacyList[index]
//                                       .description, //"Text 2",
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 )
//                               : MyText(
//                                   text: privacyList[index]
//                                       .descriptionAr, //"Text 2",
//                                   size: 14,
//                                   color: blackColor,
//                                   align: TextAlign.justify,
//                                 ),
//                         ),
//                       const Divider(
//                         thickness: 1,
//                         color: greyProfileColor,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/models/terms_conditition_mode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Map mapFilter = {};
  List<TermsConditionModel> privacyList = [];
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    getPolicy();
  }

  Future getPolicy() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      var response = await http
          .get(Uri.parse("${Constants.baseUrl}/api/v1/privacy-policy"));

      if (response.statusCode == 200) {
        mapFilter = json.decode(response.body);
        List<dynamic> result = mapFilter['data'];
        setState(() {
          privacyList.clear(); // Clear existing list
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
          privacyList.add(tc);
        });

        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load privacy policy: ${response.statusCode}';
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
          'Privacy Policy',
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
              'Loading Privacy Policy',
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
                onPressed: getPolicy,
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
          // Header information (optional)
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: Text(
          //     'Please review our privacy policy carefully',
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 16),

          // Privacy Policy List
          ...privacyList.map((policy) => _buildPolicyCard(policy))
        ],
      ),
    );
  }

  Widget _buildPolicyCard(TermsConditionModel policy) {
    // Skip empty/null content
    if ((policy.title == "null" || policy.title.isEmpty) &&
        (policy.titleAr == "null" || policy.titleAr.isEmpty)) {
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
                policy.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              )
            : Text(
                policy.titleAr,
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
                    policy.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  )
                : Text(
                    policy.descriptionAr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
          ),
        ],
      ),
    );
  }
}
