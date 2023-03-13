import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/grid/view_details_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/services_provider.dart';
import '../widgets/my_text.dart';

class ViewDetails extends StatefulWidget {
  final String type;
  const ViewDetails(this.type, {super.key});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  List<ServicesModel> gm = [];
  @override
  void initState() {
    super.initState();
    // if (widget.type == "LAND") {
    //   gm = Provider.of<ServicesProvider>(context).allLand;
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "LAND") {
      gm = Provider.of<ServicesProvider>(context).allLand;
    } else if (widget.type == "Accomodation") {
      gm = Provider.of<ServicesProvider>(context).allAccomodation;
    } else if (widget.type == "Transport") {
      gm = Provider.of<ServicesProvider>(context).allTransport;
    } else if (widget.type == "Sky") {
      gm = Provider.of<ServicesProvider>(context).allSky;
    } else if (widget.type == "Water") {
      gm = Provider.of<ServicesProvider>(context).allWater;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(
            text: 'View Details',
            color: bluishColor,
            weight: FontWeight.bold,
          ),
        ),
        body: ViewDetailsGrid(gm));
  }
}
