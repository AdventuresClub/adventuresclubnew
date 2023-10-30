import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final String sd;
  final String ed;
  final String des;
  final bool? show;
  final int? count;
  const InfoTile(this.title, this.sd, this.ed, this.des,
      {this.show = false, this.count = 0, super.key});

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime startTime = DateTime.now();
  String sTime = "";
  String eTime = "";
  String sd = "";
  String number = "";

  @override
  void initState() {
    super.initState();
    startDate = DateTime.parse(widget.sd);
    endDate = DateTime.parse(widget.ed);
    convertTime(startDate);
    converteTime(endDate);
    startTime = DateTime.tryParse(widget.ed) ?? DateTime.now();
    String sMonth = DateFormat('MMMM').format(startDate);
    sd = "${startDate.day}-$sMonth-${startDate.year}";
    number = widget.count.toString();
  }

  void convertTime(DateTime t) {
    String to = DateFormat('h:mm a').format(t);
    setState(() {
      sTime = to;
    });
  }

  void converteTime(DateTime t) {
    String to = DateFormat('h:mm a').format(t);
    setState(() {
      eTime = to;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: widget.show!
          ? CircleAvatar(
              backgroundColor: blueColor,
              radius: 28,
              child: CircleAvatar(
                backgroundColor: greenishColor,
                radius: 25,
                child: MyText(
                  text: number,
                  weight: FontWeight.bold,
                ),
              ),
            )
          : null,
      title: MyText(
        text: "${widget.title} "
            "${" "}"
            "$sd"
            "${" -"}"
            " ($sTime)", //${"-"} ", //$eTime  ",
        color: blackColor,
        weight: FontWeight.bold,
        fontFamily: 'Raleway',
        size: 15,
      ),
      subtitle: MyText(
        text: widget.des, //text[index],
        color: greyTextColor,
        weight: FontWeight.w500,
        fontFamily: 'Raleway',
        size: 14,
      ),
    );
  }
}
