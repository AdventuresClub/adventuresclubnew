// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/models/getFavourite/get_favourite.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class FavList extends StatefulWidget {
  const FavList({super.key});

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  Map mapFavourite = {};
  List<GetFavouriteModel> nm = [];
  List<ServiceImageModel> gSim = [];
  bool loading = false;
  String userId = "27";
  @override
  void initState() {
    super.initState();
    getFavourite();
  }

  Future getFavourite() async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "${Constants.baseUrl}/api/v1/get_favourite?user_id=${Constants.userId}"));
    if (response.statusCode == 200) {
      mapFavourite = json.decode(response.body);
      List<dynamic> result = mapFavourite['data'];
      result.forEach((element) {
        List<dynamic> image = element['images'];
        image.forEach((i) {
          ServiceImageModel sm = ServiceImageModel(
            int.tryParse(i['id'].toString()) ?? 0,
            int.tryParse(i['service_id'].toString()) ?? 0,
            int.tryParse(i['is_default'].toString()) ?? 0,
            i['image_url'].toString() ?? "",
            i['thumbnail'].toString() ?? "",
          );
          gSim.add(sm);
        });
        int serviceId = int.tryParse(element['service_id'].toString()) ?? 0;
        int providerId = int.tryParse(element['provider_id'].toString()) ?? 0;
        int stars = int.tryParse(element['stars'].toString()) ?? 0;
        GetFavouriteModel gc = GetFavouriteModel(
            serviceId,
            providerId,
            element['adventure_name'] ?? "",
            element['cost_inc'] ?? "",
            element['currency'] ?? "",
            element['provided_name'] ?? "",
            element['provider_profile'] ?? "",
            gSim,
            element['stars'] ?? "");
        nm.add(gc);
      });
      setState(() {
        loading = false;
      });
    }
    print(response.statusCode);
  }

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  //{CommonConstantUrl.ChatUrl}newreceiverchat/{Settings.UserId}/{completedDataModel.service_id}/{completedDataModel.provider_id}";

  double convert(String rating) {
    //double r = double.tryParse(rating)
    double result = double.parse(rating);
    return result;
  }

  double convertInt(int rating) {
    double result = rating.toDouble();
    return result;
  }

  void goToProvider(
    String id,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return About(id: id);
        },
      ),
    );
  }

  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Text("loading".tr()),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: nm.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: '',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Card(
                        child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken),
                                image: NetworkImage(
                                  "${"${Constants.baseUrl}/public/uploads/"}${nm[index].sm[index].thumbnail}",
                                ),
                                // const ExactAssetImage(
                                //   'images/Wadi-Hawar.png',
                                // ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyText(
                                          text: nm[index]
                                              .adventureName, //'Wadi Haver',
                                          color: bluishColor,
                                          size: 14,
                                          weight: FontWeight.bold,
                                          fontFamily: 'Raleway'),
                                    ),
                                    const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.favorite,
                                          color: whiteColor,
                                          size: 18,
                                        )),
                                  ],
                                ),
                                if (nm[index].stars != 0)
                                  RatingBar.builder(
                                    initialRating: convert(nm[index].stars),
                                    itemSize: 12,
                                    minRating: convert(nm[index].stars),
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
                                if (nm[index].stars == 0)
                                  RatingBar.builder(
                                    initialRating: convertInt(nm[index].stars),
                                    itemSize: 12,
                                    minRating: convertInt(nm[index].stars),
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
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                        text: "${nm[index].currency} "
                                            " ${nm[index].costInc}", //'ر.ع 20,000',
                                        color: greyColor3,
                                        size: 14,
                                        weight: FontWeight.w500,
                                        fontFamily: 'Raleway'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Image(
                                  image:
                                      const ExactAssetImage('images/line.png'),
                                  width: MediaQuery.of(context).size.width / 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => goToProvider(
                                          nm[index].providerId.toString()),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            backgroundImage: NetworkImage(
                                                nm[index].providerProfile),
                                            // ExactAssetImage(
                                            //     'images/avatar.png'),
                                            backgroundColor: transparentColor,
                                            // child: Image(
                                            //   image: NetworkImage(
                                            //       nm[index].providerProfile),
                                            //   // ExactAssetImage(
                                            //   //     'images/avatar.png'),
                                            //   fit: BoxFit.fill,
                                            // ),
                                          ),
                                          const SizedBox(width: 10),
                                          MyText(
                                              text: nm[index]
                                                  .providerName, //'Alexander',
                                              color: blackColor,
                                              size: 12,
                                              fontFamily: 'Raleway'),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => selected(
                                          context,
                                          nm[index].serviceId,
                                          nm[index].providerId),
                                      child: const Icon(
                                        Icons.chat,
                                        color: bluishColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // trailing: Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [

                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     // Image(image:  ExactAssetImage('images/line.png'),width: 40,),

                            //     // Text(
                            //     //   'Chat',
                            //     //   style: TextStyle(
                            //     //       color: bluishColor, fontFamily: 'Roboto'),
                            //     // ),
                            //   ],
                            // ),
                          ),
                        ),

                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     const SizedBox(
                        //       height: 10,
                        //     ),

                        //     const CircleAvatar(
                        //         radius: 18,
                        //         backgroundColor: Colors.red,
                        //         child: Icon(
                        //           Icons.favorite,
                        //           color: whiteColor,
                        //           size: 18,
                        //         )),
                        //     const SizedBox(
                        //       height: 20,
                        //     ),

                        //     // Image(image:  ExactAssetImage('images/line.png'),width: 40,),
                        //     GestureDetector(
                        //       onTap: () => selected(context,
                        //           nm[index].serviceId, nm[index].providerId),
                        //       child: Icon(
                        //         Icons.chat,
                        //         color: blackColor.withOpacity(0.5),
                        //         size: 30,
                        //       ),
                        //     ),
                        //     // Text(
                        //     //   'Chat',
                        //     //   style: TextStyle(
                        //     //       color: bluishColor, fontFamily: 'Roboto'),
                        //     // ),
                        //   ],
                        // ),
                      ],
                    )),
                  ));
            });
  }
}
