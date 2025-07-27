import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/models/terms_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TermsNConditions extends StatefulWidget {
  const TermsNConditions({super.key});

  @override
  State<TermsNConditions> createState() => _TermsNConditionsState();
}

class _TermsNConditionsState extends State<TermsNConditions> {
  List<Term> terms = [];
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchTerms();
  }

  Future<void> fetchTerms() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    const url =
        "https://adventuresclub.net/ProdBackup/api/v1/contract-conditions";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['data'];
        final fetchedTerms = data.map((item) => Term.fromJson(item)).toList();

        setState(() {
          terms = fetchedTerms;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load terms: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Terms & Conditions'),
  //     ),
  //     body: isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : error.isNotEmpty
  //             ? Center(child: Text('Error: $error'))
  //             : ListView.builder(
  //                 padding: const EdgeInsets.all(16),
  //                 itemCount: terms.length,
  //                 itemBuilder: (context, index) {
  //                   final term = terms[index];
  //                   return Card(
  //                     elevation: 3,
  //                     margin: const EdgeInsets.symmetric(vertical: 8),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(16),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             term.title,
  //                             style: const TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 8),
  //                           Text(
  //                             term.description,
  //                             style: const TextStyle(fontSize: 16),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partnership contract terms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              //color: Colors.white,
            )),
        centerTitle: true,
        // backgroundColor: Colors.teal[700],
        elevation: 0,
        //iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
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
                onPressed: () {}, //_retry,
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          // Header
          const Text(
            'Please review our terms carefully',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          // const Text(
          //   'Last updated: June 2023',
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.grey,
          //   ),
          // ),
          //const SizedBox(height: 24),

          // Terms List
          ...terms.map((term) => _buildTermCard(term)).toList(),

          // Accept Button
          // Padding(
          //   padding: const EdgeInsets.only(top: 12),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       onPressed: () {}, //_acceptTerms,
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.teal[700],
          //         padding: const EdgeInsets.symmetric(vertical: 16),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         elevation: 0,
          //       ),
          //       child: const Text(
          //         'Accept & Continue',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTermCard(Term term) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        // leading: Icon(
        //   Icons.label_important,
        //   color: kSecondaryColor,
        // ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        title: Text(
          term.title,
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
          Text(
            term.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[900],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
