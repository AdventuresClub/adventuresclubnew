// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  final hinttext;
  final width;
  final height;
  final controller;
  final String image;
  final bool value;
  final bool countryName;
  final String country;
  final double fontSize;
  const SearchContainer(this.hinttext, this.width, this.height, this.controller,
      this.image, this.value, this.countryName, this.country, this.fontSize,
      {Key? key})
      : super(key: key);

  @override
  SearchContainerState createState() => SearchContainerState();
}

class SearchContainerState extends State<SearchContainer> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      width: MediaQuery.of(context).size.width / widget.width,
      height: MediaQuery.of(context).size.width / widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.4), width: 1.7),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.search,
                color: greyColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Center(
                child: SizedBox(
                  width: widget.countryName == true
                      ? MediaQuery.of(context).size.width / 2.4
                      : MediaQuery.of(context).size.width / 1.7,
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(top: 2),
                        hintText: widget.hinttext.toString(),
                        border: InputBorder.none,
                        hintStyle: const TextStyle(fontSize: 14)),
                  ),
                ),
              ),
              // Text(
              //   widget.hinttext,
              //   style: TextStyle(
              //       color: searchTextColor.withOpacity(0.8),
              //       fontSize: widget.fontSize),
              // ),
            ],
          ),
          Row(
            children: [
              if (widget.countryName == true)
                Text(
                  Constants.country.tr(),
                  style: TextStyle(
                    color: searchTextColor.withOpacity(0.8),
                    fontSize: widget.fontSize,
                  ),
                ),
              const SizedBox(
                width: 5,
              ),
              if (widget.value == true)
                Image.network(
                  "${"${Constants.baseUrl}/public/"}${Constants.countryFlag}",
                  height: 15,
                  width: 15,
                ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
