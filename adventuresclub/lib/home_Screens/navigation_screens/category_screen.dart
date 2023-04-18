import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String type;
  const CategoryScreen(this.type, {super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool loading = false;
  List<ServicesModel> gm = [];

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Details(gm: gm);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "Accomodation") {
      gm = Provider.of<ServicesProvider>(context).allAccomodation;
    } else if (widget.type == "Transport") {
      gm = Provider.of<ServicesProvider>(context).allTransport;
    } else if (widget.type == "Sky") {
      gm = Provider.of<ServicesProvider>(context).allSky;
    } else if (widget.type == "Water") {
      gm = Provider.of<ServicesProvider>(context).allWater;
    } else if (widget.type == "LAND") {
      gm = Provider.of<ServicesProvider>(context).allLand;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: blackColor),
        title: MyText(
          text: "View Details",
          weight: FontWeight.bold,
          color: blackColor,
        ),
      ),
      body: loading
          ? Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text("Loading...")
                ],
              ),
            )
          : SingleChildScrollView(
              child: GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 0.2,
                childAspectRatio: 0.84,
                crossAxisSpacing: 0.2,
                crossAxisCount: 2,
                children: List.generate(
                  gm.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => goToDetails(gm[index]),
                      child: ServicesCard(gm[index]),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
