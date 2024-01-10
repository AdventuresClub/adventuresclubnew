// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/home_Screens/new_details.dart';
import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/services/create_services/availability_plan_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/filter_data_model/programs_model.dart';
import '../../models/home_services/become_partner.dart';
import '../../models/home_services/services_model.dart';
import '../../models/services/aimed_for_model.dart';
import '../../models/services/availability_model.dart';
import '../../models/services/booking_data_model.dart';
import '../../models/services/dependencies_model.dart';
import '../../models/services/included_activities_model.dart';
import '../../models/services/manish_model.dart';
import '../../models/services/service_image_model.dart';
import '../details.dart';

class Planned extends StatefulWidget {
  const Planned({super.key});

  @override
  State<Planned> createState() => _PlannedState();
}

class _PlannedState extends State<Planned> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  late CalendarFormat _calendarFormat;
  Map getServicesMap = {};
  bool loading = false;
  String id = "1";
  String day = "";
  List<AvailabilityModel> gAm = [];
  List<ServiceImageModel> gSim = [];
  List<IncludedActivitiesModel> gIAm = [];
  List<DependenciesModel> gdM = [];
  List<ProgrammesModel> gPm = [];
  List<AimedForModel> gAfm = [];
  List<BookingDataModel> gBdm = [];
  List<ManishModel> gMm = [];
  List<HomeServicesModel> gm = [];
  List<HomeServicesModel> pGm = [];
  List<ServicesModel> ngSM = [];
  List<BecomePartner> nBp = [];
  List<ServicesModel> allSer = [];
  DateTime selDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    filter();
  }

  // Future getServicesList() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.post(
  //       Uri.parse(
  //           "${Constants.baseUrl}/api/v1/get_allservices"),
  //       body: {
  //         "country_id": id,
  //       });
  //   if (response.statusCode == 200) {
  //     var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     List<dynamic> result = getServicesMap['data'];
  //     result.forEach((element) {
  //       List<dynamic> s = element['services'];
  //       s.forEach((services) {
  //         List<dynamic> available = services['availability'];
  //         available.forEach((a) {
  //           AvailabilityModel am = AvailabilityModel(
  //               a['start_date'].toString() ?? "",
  //               a['end_date'].toString() ?? "");
  //           gAm.add(am);
  //         });
  //         List<dynamic> becomePartner = services['become_partner'];
  //         becomePartner.forEach((b) {
  //           BecomePartner bp = BecomePartner(
  //               b['cr_name'].toString() ?? "",
  //               b['cr_number'].toString() ?? "",
  //               b['description'].toString() ?? "");
  //         });
  //         List<dynamic> aF = services['aimed_for'];
  //         aF.forEach((a) {
  //           AimedForModel afm = AimedForModel(
  //             int.tryParse(a['id'].toString()) ?? 0,
  //             a['AimedName'].toString() ?? "",
  //             a['image'].toString() ?? "",
  //             a['created_at'].toString() ?? "",
  //             a['updated_at'].toString() ?? "",
  //             a['deleted_at'].toString() ?? "",
  //             int.tryParse(a['service_id'].toString()) ?? 0,
  //           );
  //           gAfm.add(afm);
  //         });
  //         List<dynamic> image = services['images'];
  //         image.forEach((i) {
  //           ServiceImageModel sm = ServiceImageModel(
  //             int.tryParse(i['id'].toString()) ?? 0,
  //             int.tryParse(i['service_id'].toString()) ?? 0,
  //             int.tryParse(i['is_default'].toString()) ?? 0,
  //             i['image_url'].toString() ?? "",
  //             i['thumbnail'].toString() ?? "",
  //           );
  //           gSim.add(sm);
  //         });
  //         ServicesModel nSm = ServicesModel(
  //           int.tryParse(services['id'].toString()) ?? 0,
  //           int.tryParse(services['owner'].toString()) ?? 0,
  //           services['adventure_name'].toString() ?? "",
  //           services['country'].toString() ?? "",
  //           services['region'].toString() ?? "",
  //           services['city_id'].toString() ?? "",
  //           services['service_sector'].toString() ?? "",
  //           services['service_category'].toString() ?? "",
  //           services['service_type'].toString() ?? "",
  //           services['service_level'].toString() ?? "",
  //           services['duration'].toString() ?? "",
  //           int.tryParse(services['availability_seats'].toString()) ?? 0,
  //           int.tryParse(services['start_date'].toString()) ?? "",
  //           int.tryParse(services['end_date'].toString()) ?? "",
  //           services['latitude'].toString() ?? "",
  //           services['longitude'].toString() ?? "",
  //           services['write_information'].toString() ?? "",
  //           int.tryParse(services['service_plan'].toString()) ?? 0,
  //           int.tryParse(services['sfor_id'].toString()) ?? 0,
  //           gAm,
  //           services['geo_location'].toString() ?? "",
  //           services['specific_address'].toString() ?? "",
  //           services['cost_inc'].toString() ?? "",
  //           services['cost_exc'].toString() ?? "",
  //           services['currency'].toString() ?? "",
  //           int.tryParse(services['points'].toString()) ?? 0,
  //           services['pre_requisites'].toString() ?? "",
  //           services['minimum_requirements'].toString() ?? "",
  //           services['terms_conditions'].toString() ?? "",
  //           int.tryParse(services['recommended'].toString()) ?? 0,
  //           services['status'].toString() ?? "",
  //           services['image'].toString() ?? "",
  //           services['descreption]'].toString() ?? "",
  //           services['favourite_image'].toString() ?? "",
  //           services['created_at'].toString() ?? "",
  //           services['updated_at'].toString() ?? "",
  //           services['delete_at'].toString() ?? "",
  //           int.tryParse(services['provider_id'].toString()) ?? 0,
  //           int.tryParse(services['service_id'].toString()) ?? 0,
  //           services['provider_name'].toString() ?? "",
  //           services['provider_profile'].toString() ?? "",
  //           services['including_gerea_and_other_taxes'].toString() ?? "",
  //           services['excluding_gerea_and_other_taxes'].toString() ?? "",
  //           nBp,
  //           gAfm,
  //           services['stars'].toString() ?? "",
  //           int.tryParse(services['is_liked'].toString()) ?? 0,
  //           services['baseurl'].toString() ?? "",
  //           gSim,
  //         );
  //         ngSM.add(nSm);
  //       });
  //       HomeServicesModel sm =
  //           HomeServicesModel(element['category'].toString() ?? "", ngSM);
  //       gm.add(sm);
  //     });
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // Future getServicesList() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.get(Uri.parse(
  //       "${Constants.baseUrl}/api/v1/services/$id"));
  //   if (response.statusCode == 200) {
  //     getServicesMap = json.decode(response.body);
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
  //     pGm.add(sm);
  //   }
  // }

  Future listClear() async {
    pGm.clear();
    gm.clear();
  }

  void filter() async {
    await listClear();
    //gm.removeLast();
    //await getServicesList();
    pGm.forEach(
      (element) {
        List<AvailabilityModel> am = element.sm[0].availability;
        am.forEach(
          (a) {
            if (day
                //_selectedDay.weekday
                ==
                a.st) {
              gm.add(element);
            }
          },
        );
      },
    );
    setState(() {
      loading = false;
    });
  }

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return NewDetails(gm: gm);
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

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  List<ServicesModel> getFilterData(List<ServicesModel> data) {
    List<ServicesModel> filterList = [];
    data.forEach((element) {
      if (element.sPlan == 1) {
        List<AvailabilityPlanModel> availability = element.availabilityPlan;
        for (AvailabilityPlanModel a in availability) {
          //availability.forEach((a) {
          if (Constants.convertDaysNumToString(_selectedDay.weekday) == a.day) {
            filterList.add(element);
            break;
          }
          //});
        }
      } else {
        if (_selectedDay.isAfter(element.startDate) &&
            _selectedDay.isBefore(element.endDate)) {
          filterList.add(element);
        }
      }
    });
    return filterList;
  }

  @override
  Widget build(BuildContext context) {
    allSer = getFilterData(Provider.of<ServicesProvider>(context).allServices);
    return Scaffold(
      backgroundColor: greyProfileColor,
      body: Column(
        children: [
          SizedBox(
            height: 155,
            child: //HomeCalendarPage(),
                Card(
              elevation: 1,
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                daysOfWeekVisible: true,
                daysOfWeekHeight: 20,
                pageJumpingEnabled: true,
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: greyColor, fontWeight: FontWeight.w600)),
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    focusedDay = _focusedDay;
                    day = DateFormat('EEEE').format(_selectedDay);
                    print(day);
                  });
                  //gm.clear();
                  // pGm.clear();
                  // filter();
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here

                  _focusedDay = _selectedDay;
                  focusedDay = _focusedDay;
                },
                calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(color: bluishColor),
                    // todayColor: Colors.blue,
                    selectedDecoration: BoxDecoration(color: bluishColor),
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.black)),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    if (day.weekday == DateTime.sunday) {
                      final text = DateFormat.E().format(day);
                      return Center(
                        child: Text(
                          text.tr(),
                          style: const TextStyle(
                              color: greyColor, fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  },
                  selectedBuilder: (context, datetime, focusedDay) {
                    return Container(
                      decoration: BoxDecoration(
                          color: bluishColor,
                          borderRadius: BorderRadius.circular(32.0)),
                      margin: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          datetime.day.toString().tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(32.0)),
                      child: Text(
                        date.day.toString().tr(),
                        style: const TextStyle(
                            color: blackColor, fontWeight: FontWeight.w600),
                      )),
                ),
                firstDay: DateTime.now().subtract(const Duration(days: 0)),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _selectedDay, //DateTime.now(),
              ),
            ),
          ),
          loading
              ? Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      Text("loading".tr())
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: 'scheduledSessions'.tr(),
                    color: greyColor,
                    weight: FontWeight.bold,
                  )),
          const SizedBox(
            height: 5,
          ),
          allSer.isEmpty
              ? const Center(
                  child: Text("No Adventure At this date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: greyColor)),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: allSer.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => goToDetails(allSer[index]),
                            child: SizedBox(
                                height: 300,
                                child: ServicesCard(allSer[index])));
                      }),
                ),
          // SingleChildScrollView(
          //     child: GridView.count(
          //       physics: const ScrollPhysics(),
          //       shrinkWrap: true,
          //       mainAxisSpacing: 0.4,
          //       childAspectRatio: 1,
          //       crossAxisSpacing: 0.2,
          //       crossAxisCount: 2,
          //       children: List.generate(
          //         allSer.length,
          //         (index) {
          //           return GestureDetector(
          //             onTap: () => goToDetails(allSer[index]),
          //             child: ServicesCard(allSer[index]),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
