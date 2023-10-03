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

class RecommendedActivity extends StatefulWidget {
  const RecommendedActivity({super.key});

  @override
  State<RecommendedActivity> createState() => _RecommendedActivityState();
}

class _RecommendedActivityState extends State<RecommendedActivity> {
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

  // Future getServicesList1() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.post(
  //       Uri.parse(
  //           "https://adventuresclub.net/adventureClub/api/v1/get_allservices"
  //           //"https://adventuresclub.net/adventureClub/api/v1/services/$id"
  //           ),
  //       body: {
  //         "country_id": id,
  //       });
  //   if (response.statusCode == 200) {
  //     var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     // getServicesMap = json.decode(response.body);
  //     dynamic result = getServicesMap['data'];
  //     List<dynamic> available = result['availability'];
  //     available.forEach((a) {
  //       AvailabilityModel am = AvailabilityModel(
  //           int.tryParse(a['id'].toString()) ?? 0, a['day'].toString() ?? "");
  //       gAm.add(am);
  //     });
  //     List<dynamic> image = result['images'];
  //     image.forEach((i) {
  //       ServiceImageModel sm = ServiceImageModel(
  //         int.tryParse(i['id'].toString()) ?? 0,
  //         int.tryParse(i['service_id'].toString()) ?? 0,
  //         int.tryParse(i['is_default'].toString()) ?? 0,
  //         i['image_url'].toString() ?? "",
  //         i['thumbnail'].toString() ?? "",
  //       );
  //       gSim.add(sm);
  //     });
  //     List<dynamic> aF = result['aimed_for'];
  //     aF.forEach((a) {
  //       AimedForModel afm = AimedForModel(
  //         int.tryParse(a['id'].toString()) ?? 0,
  //         a['AimedName'].toString() ?? "",
  //         a['image'].toString() ?? "",
  //         a['created_at'].toString() ?? "",
  //         a['updated_at'].toString() ?? "",
  //         a['deleted_at'].toString() ?? "",
  //         int.tryParse(a['service_id'].toString()) ?? 0,
  //       );
  //       gAfm.add(afm);
  //     });
  //     List<dynamic> s = result['services'];
  //     s.forEach((services) {
  //       ServicesModel nSm = ServicesModel(
  //         int.tryParse(result['id'].toString()) ?? 0,
  //       int.tryParse(result['owner'].toString()) ?? 0,
  //       result['adventure_name'].toString() ?? "",
  //       result['country'].toString() ?? "",
  //       result['region'].toString() ?? "",
  //       result['city_id'].toString() ?? "",
  //       result['service_sector'].toString() ?? "",
  //       result['service_category'].toString() ?? "",
  //       result['service_type'].toString() ?? "",
  //       result['service_level'].toString() ?? "",
  //       result['duration'].toString() ?? "",
  //       int.tryParse(result['availability_seats'].toString()) ?? 0,
  //       int.tryParse(result['start_date'].toString()) ?? "",
  //       int.tryParse(result['end_date'].toString()) ?? "",
  //       result['latitude'].toString() ?? "",
  //       result['longitude'].toString() ?? "",
  //       result['write_information'].toString() ?? "",
  //       int.tryParse(result['service_plan'].toString()) ?? 0,
  //       int.tryParse(result['sfor_id'].toString()) ?? 0,
  //       gAm,
  //       result['geo_location'].toString() ?? "",
  //       result['specific_address'].toString() ?? "",
  //       result['cost_inc'].toString() ?? "",
  //       result['cost_exc'].toString() ?? "",
  //       result['currency'].toString() ?? "",
  //       int.tryParse(result['points'].toString()) ?? 0,
  //       result['pre_requisites'].toString() ?? "",
  //       result['minimum_requirements'].toString() ?? "",
  //       result['terms_conditions'].toString() ?? "",
  //       int.tryParse(result['recommended'].toString()) ?? 0,
  //       result['status'].toString() ?? "",
  //       result['image'].toString() ?? "",
  //       result['descreption]'].toString() ?? "",
  //       result['favourite_image'].toString() ?? "",
  //       result['created_at'].toString() ?? "",
  //       result['updated_at'].toString() ?? "",
  //       result['delete_at'].toString() ?? "",
  //       int.tryParse(result['provider_id'].toString()) ?? 0,
  //       int.tryParse(result['service_id'].toString()) ?? 0,
  //       result['provider_name'].toString() ?? "",
  //       result['provider_profile'].toString() ?? "",
  //       result['including_gerea_and_other_taxes'].toString() ?? "",
  //       result['excluding_gerea_and_other_taxes'].toString() ?? "",
  //       nBp,
  //       gAfm,
  //       result['stars'].toString() ?? "",
  //       int.tryParse(result['is_liked'].toString()) ?? 0,
  //       result['baseurl'].toString() ?? "",
  //       gSim,
  //           );
  //     HomeServicesModel sm = HomeServicesModel(
  //       result['category'].toString() ?? "",
  //       nSm,
  //     );
  //     gm.add(sm);
  //     setState(() {
  //       loading = false;
  //     });

  // Future getServicesList1(String? day) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.post(
  //       Uri.parse(
  //           "https://adventuresclub.net/adventureClub/api/v1/get_allservices"
  //           //"https://adventuresclub.net/adventureClub/api/v1/services/$id"
  //           ),
  //       body: {
  //         "country_id": id,
  //       });
  //   if (response.statusCode == 200) {
  //     var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     // getServicesMap = json.decode(response.body);
  //     dynamic result = getServicesMap['data'];
  //     List<dynamic> available = result['availability'];
  //     available.forEach((a) {
  //       AvailabilityModel am = AvailabilityModel(
  //           int.tryParse(a['id'].toString()) ?? 0, a['day'].toString() ?? "");
  //       gAm.add(am);
  //     });
  //     List<dynamic> image = result['images'];
  //     image.forEach((i) {
  //       ServiceImageModel sm = ServiceImageModel(
  //         int.tryParse(i['id'].toString()) ?? 0,
  //         int.tryParse(i['service_id'].toString()) ?? 0,
  //         int.tryParse(i['is_default'].toString()) ?? 0,
  //         i['image_url'].toString() ?? "",
  //         i['thumbnail'].toString() ?? "",
  //       );
  //       gSim.add(sm);
  //     });
  //     List<dynamic> iActivities = result['included_activities'];
  //     iActivities.forEach((iA) {
  //       IncludedActivitiesModel iAm = IncludedActivitiesModel(
  //         int.tryParse(iA['id'].toString()) ?? 0,
  //         int.tryParse(iA['service_id'].toString()) ?? 0,
  //         iA['activity_id'].toString() ?? "",
  //         iA['activity'].toString() ?? "",
  //         iA['image'].toString() ?? "",
  //       );
  //       gIAm.add(iAm);
  //     });
  //     List<dynamic> dependency = result['dependencies'];
  //     dependency.forEach((d) {
  //       DependenciesModel dm = DependenciesModel(
  //         int.tryParse(d['id'].toString()) ?? 0,
  //         d['dependency_name'].toString() ?? "",
  //         d['image'].toString() ?? "",
  //         d['updated_at'].toString() ?? "",
  //         d['created_at'].toString() ?? "",
  //         d['deleted_at'].toString() ?? "",
  //       );
  //       gdM.add(dm);
  //     });
  //     List<dynamic> programs = result['programs'];
  //     programs.forEach((p) {
  //       ProgrammesModel pm = ProgrammesModel(
  //         int.tryParse(p['id'].toString()) ?? 0,
  //         int.tryParse(p['service_id'].toString()) ?? 0,
  //         p['title'].toString() ?? "",
  //         p['start_datetime'].toString() ?? "",
  //         p['end_datetime'].toString() ?? "",
  //         p['description'].toString() ?? "",
  //       );
  //       gPm.add(pm);
  //     });
  //     List<dynamic> aF = result['aimed_for'];
  //     aF.forEach((a) {
  //       AimedForModel afm = AimedForModel(
  //         int.tryParse(a['id'].toString()) ?? 0,
  //         a['AimedName'].toString() ?? "",
  //         a['image'].toString() ?? "",
  //         a['created_at'].toString() ?? "",
  //         a['updated_at'].toString() ?? "",
  //         a['deleted_at'].toString() ?? "",
  //         int.tryParse(a['service_id'].toString()) ?? 0,
  //       );
  //       gAfm.add(afm);
  //     });
  //     List<dynamic> booking = result['bookingData'];
  //     booking.forEach((b) {
  //       BookingDataModel bdm = BookingDataModel(
  //         int.tryParse(b['id'].toString()) ?? 0,
  //         int.tryParse(b['user_id'].toString()) ?? 0,
  //         int.tryParse(b['service_id'].toString()) ?? 0,
  //         int.tryParse(b['transaction_id'].toString()) ?? 0,
  //         int.tryParse(b['pay_status'].toString()) ?? 0,
  //         int.tryParse(b['provider_id'].toString()) ?? 0,
  //         int.tryParse(b['adult'].toString()) ?? 0,
  //         int.tryParse(b['kids'].toString()) ?? 0,
  //         b['message'].toString() ?? "",
  //         b['unit_amount'].toString() ?? "",
  //         b['total_amount'].toString() ?? "",
  //         b['discounted_amount'].toString() ?? "",
  //         int.tryParse(b['future_plan'].toString()) ?? 0,
  //         b['booking_date'].toString() ?? "",
  //         int.tryParse(b['currency'].toString()) ?? 0,
  //         int.tryParse(b['coupon_applied'].toString()) ?? 0,
  //         b['status'].toString() ?? "",
  //         int.tryParse(b['updated_by'].toString()) ?? 0,
  //         b['cancelled_reason'].toString() ?? "",
  //         b['payment_status'].toString() ?? "",
  //         b['payment_channel'].toString() ?? "",
  //         b['deleted_at'].toString() ?? "",
  //         b['created_at'].toString() ?? "",
  //         b['updated_at'].toString() ?? "",
  //       );
  //       gBdm.add(bdm);
  //     });
  //     GetServicesModel sm = GetServicesModel(
  //       int.tryParse(result['id'].toString()) ?? 0,
  //       int.tryParse(result['owner'].toString()) ?? 0,
  //       result['adventure_name'].toString() ?? "",
  //       result['country'].toString() ?? "",
  //       result['region'].toString() ?? "",
  //       result['city_id'].toString() ?? "",
  //       result['service_sector'].toString() ?? "",
  //       result['service_category'].toString() ?? "",
  //       result['service_type'].toString() ?? "",
  //       result['service_level'].toString() ?? "",
  //       result['duration'].toString() ?? "",
  //       int.tryParse(result['availability_seats'].toString()) ?? 0,
  //       int.tryParse(result['start_date'].toString()) ?? "",
  //       int.tryParse(result['end_date'].toString()) ?? "",
  //       result['latitude'].toString() ?? "",
  //       result['longitude'].toString() ?? "",
  //       result['write_information'].toString() ?? "",
  //       int.tryParse(result['service_plan'].toString()) ?? 0,
  //       int.tryParse(result['sfor_id'].toString()) ?? 0,
  //       gAm,
  //       result['geo_location'].toString() ?? "",
  //       result['specific_address'].toString() ?? "",
  //       result['cost_inc'].toString() ?? "",
  //       result['cost_exc'].toString() ?? "",
  //       result['currency'].toString() ?? "",
  //       int.tryParse(result['points'].toString()) ?? 0,
  //       result['pre_requisites'].toString() ?? "",
  //       result['minimum_requirements'].toString() ?? "",
  //       result['terms_conditions'].toString() ?? "",
  //       int.tryParse(result['recommended'].toString()) ?? 0,
  //       result['status'].toString() ?? "",
  //       result['image'].toString() ?? "",
  //       result['descreption]'].toString() ?? "",
  //       result['favourite_image'].toString() ?? "",
  //       result['created_at'].toString() ?? "",
  //       result['updated_at'].toString() ?? "",
  //       result['delete_at'].toString() ?? "",
  //       int.tryParse(result['provider_id'].toString()) ?? 0,
  //       result['provider_name'].toString() ?? "",
  //       result['provider_profile'].toString() ?? "",
  //       result['thumbnail'].toString() ?? "",
  //       result['rating'].toString() ?? "",
  //       int.tryParse(result['reviewed_by'].toString()) ?? 0,
  //       int.tryParse(result['is_liked'].toString()) ?? 0,
  //       result['baseurl'].toString() ?? "",
  //       gSim,
  //       gIAm,
  //       gdM,
  //       gPm,
  //       int.tryParse(result['stars'].toString()) ?? 0,
  //       int.tryParse(result['booked_seats'].toString()) ?? 0,
  //       gAfm,
  //       int.tryParse(result['booking'].toString()) ?? 0,
  //       gBdm,
  //       gMm,
  //       int.tryParse(result['booking'].toString()) ?? 0,
  //     );
  //     gm.add(sm);
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

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
    gm = Provider.of<ServicesProvider>(context).allServices;
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
                  // key: Key(gm[index].id.toString()),
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
                                    image:
                                        // ExactAssetImage(
                                        //   'images/overseas.png',
                                        // ),
                                        NetworkImage(
                                      "${"https://adventuresclub.net/adventureClub/public/uploads/"}${gm[index].images[2].thumbnail}",
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
