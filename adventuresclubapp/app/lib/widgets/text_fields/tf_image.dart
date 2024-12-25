// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class TfImage extends StatefulWidget {
  final hinttext;
  final image;
  final width;
  final controller;
  const TfImage(this.hinttext, this.image, this.width, this.controller,
      {super.key});

  @override
  State<TfImage> createState() => _TfImageState();
}

class _TfImageState extends State<TfImage> {
  String countryName = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
          onTap: () => showCountryPicker(
              context: context,
              countryListTheme: CountryListThemeData(
                flagSize: 25,
                backgroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, color: Colors.blueGrey),
                bottomSheetHeight: 500, // Optional. Country list modal height
                //Optional. Sets the border radius for the bottomsheet.
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                //Optional. Styles the search field.
                inputDecoration: InputDecoration(
                  labelText: widget.hinttext,
                  hintText: widget.hinttext,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              onSelect: (Country country) => setState(() {
                    countryName = country.displayName;
                  })
              //print('Select country: ${country.displayName}'),

              ),
          tileColor: whiteColor,
          selectedTileColor: whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: MyText(text: ''),
          trailing: const Image(
            image: ExactAssetImage('images/ic_drop_down.png'),
            height: 16,
            width: 16,
          )),
    );
  }
}
