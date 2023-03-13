import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final hinttext;
  final width;
  final height;
  final String image;
  final bool value;
  final bool countryName;
  final String country;
  final double fontSize;
  const SearchContainer(this.hinttext, this.width, this.height, this.image,
      this.value, this.countryName, this.country, this.fontSize,
      {Key? key})
      : super(key: key);

  @override
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.hinttext,
                style: TextStyle(
                    color: searchTextColor.withOpacity(0.8),
                    fontSize: widget.fontSize),
              ),
            ],
          ),
          Row(
            children: [
              if (widget.countryName == true)
                Text(
                  widget.country,
                  style: TextStyle(
                      color: searchTextColor.withOpacity(0.8),
                      fontSize: widget.fontSize),
                ),
              if (widget.value == true)
                Image(
                  image: ExactAssetImage(widget.image),
                  height: 20,
                ),
              const SizedBox(
                width: 5,
              )
            ],
          )
        ],
      ),
    );
  }
}
