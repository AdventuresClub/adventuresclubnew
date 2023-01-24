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
  const SearchContainer(this.hinttext, this.width,this.height, this.image, this.value,this.countryName,this.country,this.fontSize,
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
      height:MediaQuery.of(context).size.width / widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: greyColor.withOpacity(0.4),
        ),
        color: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                Text(
                  widget.hinttext,
                  style: TextStyle(color: searchTextColor.withOpacity(0.6),fontSize: widget.fontSize),
                ),
              ],
            ),
           
              Row(
                children: [
                  
                   if (widget.countryName == true)
                   Text(
                  widget.country,
                  style: TextStyle(color: searchTextColor.withOpacity(0.6),fontSize: widget.fontSize),
                ),
                 if (widget.value == true)
                  Image(
                    image: ExactAssetImage(widget.image),
                    height: 20,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
