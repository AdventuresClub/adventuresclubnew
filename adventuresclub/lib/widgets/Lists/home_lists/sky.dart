// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/booking_data_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/get_services_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/manish_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../models/services/service_image_model.dart';

class Sky extends StatefulWidget {
  const Sky({super.key});

  @override
  State<Sky> createState() => SkyState();
}

class SkyState extends State<Sky> {
  Map getServicesMap = {};
  bool loading = false;
  String id = "1";
  List<AvailabilityModel> gAccomodoationAvaiModel = [];
  List<AvailabilityModel> gTransportAvaiModel = [];
  List<AvailabilityModel> gSkyAvaiModel = [];
  List<AvailabilityModel> gWaterAvaiModel = [];
  List<AvailabilityModel> gLandAvaiModel = [];

  List<ServiceImageModel> gAccomodationServImgModel = [];
  List<ServiceImageModel> gTransportServImgModel = [];
  List<ServiceImageModel> gSkyServImgModel = [];
  List<ServiceImageModel> gWaterServImgModel = [];
  List<ServiceImageModel> gLandServImgModel = [];

  List<IncludedActivitiesModel> gIAm = [];
  List<DependenciesModel> gdM = [];
  List<ProgrammesModel> gPm = [];
  List<AimedForModel> gAccomodationAimedfm = [];
  List<AimedForModel> gTransportAimedfm = [];
  List<AimedForModel> gSkyAimedfm = [];
  List<AimedForModel> gWaterAimedfm = [];
  List<AimedForModel> gLandAimedfm = [];

  List<BookingDataModel> gBdm = [];
  List<ManishModel> gMm = [];
  List<GetServicesModel> oGm = [];
  // List<HomeServicesModel> gm = [];
  List<BecomePartner> nBp = [];
  List<BecomePartner> transportBp = [];
  List<BecomePartner> skyBp = [];
  List<BecomePartner> waterBp = [];
  List<BecomePartner> landBp = [];
  // List<ServicesModel> gAccomodationSModel = [];
  // List<ServicesModel> gTransportSModel = [];
  // List<ServicesModel> gSkyServicesModel = [];
  // List<ServicesModel> gWaterServicesModel = [];
  // List<ServicesModel> gLandServicesModel = [];
  // List<HomeServicesModel> accomodation = [];
  // List<HomeServicesModel> transport = [];
  // List<HomeServicesModel> sky = [];
  // List<HomeServicesModel> water = [];
  // List<HomeServicesModel> land = [];
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

  void goToProvider() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const About();
        },
      ),
    );
  }

  List activityHeading = [
    'Cycling',
    'Summit Hike',
    'Kit Surfing',
    'Paramotor...',
    'Scuba diving',
    'Sky diving',
    'Highline ad...',
  ];

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    gm = Provider.of<ServicesProvider>(context).allSky;
    return loading
        ? Center(
            child: Column(
              children: const [
                Text("Loading ....."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator()
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: gm.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => goToDetails(gm[index]),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    // colorFilter: ColorFilter.mode(
                                    //     Colors.black.withOpacity(0.1),
                                    //     BlendMode.darken),
                                    // image: ExactAssetImage(
                                    //   'images/overseas.png',
                                    // ),
                                    image: NetworkImage(
                                      "${"https://adventuresclub.net/adventureClub/public/uploads/"}${gm[index].images[index].imageUrl}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const Positioned(
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: transparentColor,
                                child: Image(
                                  image: ExactAssetImage(
                                    'images/heart.png',
                                  ),
                                  height: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: gm[index].adventureName,
                                      maxLines: 1,
                                      color: blackColor,
                                      size: 14,
                                      weight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                    ),
                                    MyText(
                                      text: gm[index].geoLocation,
                                      overFlow: TextOverflow.clip,
                                      maxLines: 1,
                                      //text: 'Dhufar',
                                      color: greyColor2,
                                      size: 11,
                                      height: 1.3,
                                    ),
                                    MyText(
                                      text: gm[index].serviceLevel,
                                      //text: 'Advanced',
                                      color: blackTypeColor3,
                                      size: 10,
                                      height: 1.3,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                          text: gm[index].am[0].aimedName,
                                          color: redColor,
                                          size: 10,
                                          height: 1.3,
                                        ),
                                        const SizedBox(width: 10),
                                        // MyText(
                                        //   text: gm[index]
                                        //       .aimedFor[index]
                                        //       .aimedName,
                                        //   color: redColor,
                                        //   size: 10,
                                        //   height: 1.3,
                                        // ),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     MyText(
                                    //       text: 'Mixed...',
                                    //       color: redColor,
                                    //       size: 10,
                                    //       height: 1.3,
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     MyText(
                                    //       text: 'Girls',
                                    //       color: redColor,
                                    //       size: 10,
                                    //       height: 1.3,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: RatingBar.builder(
                                      initialRating:
                                          convert(gm[index].stars.toString()),
                                      itemSize: 10,
                                      //minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  MyText(
                                    text: 'Earn ${gm[index].points} points',
                                    color: blueTextColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  MyText(
                                    text: '',
                                    color: blueTextColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  MyText(
                                    text: "${gm[index].costExc} "
                                        "${gm[index].currency}",
                                    //text: 'OMR 20.00',
                                    color: blackTypeColor3,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Image(
                          image: const ExactAssetImage(
                            'images/line.png',
                          ),
                          width: MediaQuery.of(context).size.width / 2.4,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: goToProvider,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: transparentColor,
                                    child: Image(
                                      height: 70,
                                      width: 60,
                                      image: NetworkImage(gm[index].pProfile),
                                      //ExactAssetImage('images/avatar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Provided By ",
                                            style: TextStyle(
                                              color: greyColor3,
                                              fontSize: 10,
                                            )),
                                        TextSpan(
                                          text: gm[index].pName,
                                          //text: 'AdventuresClub',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: blackTypeColor4,
                                              fontSize: 11,
                                              fontFamily: "Roboto"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
