// ignore_for_file: unused_field, prefer_final_fields, avoid_print
import 'dart:async';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/book_ticket.dart';
import 'package:adventuresclub/home_Screens/plan%20_for_future.dart';
import 'package:adventuresclub/new_signup/new_register.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/details_tabs.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/newdetails_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/home_services/services_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/buttons/button.dart';

class NewDetails extends StatefulWidget {
  final ServicesModel? gm;
  final bool? show;
  const NewDetails({this.gm, this.show, super.key});

  @override
  State<NewDetails> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<NewDetails> {
  final PageController _pageViewController = PageController(initialPage: 0);
  bool favourite = false;
  int _activePage = 0;
  int index = 0;
  bool future = false;
  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController

    _timer.cancel();
  }

  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_activePage < 6) {
        _activePage++;
      } else {
        _activePage = 0;
      }

      _pageViewController.animateToPage(
        _activePage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    if (widget.gm!.sPlan == 2) {
      DateTime d = widget.gm!.startDate;
      DateTime now = DateTime.now();
      if (d.year < now.year) {
        future = true;
      } else if (d.month < now.month) {
        future = true;
      } else if (d.day <= now.day) {
        future = true;
      }
    }
    setState(() {});
  }

  abc() {}
  void goToPlan() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PlanForFuture();
        },
      ),
    );
  }

  void goToBookTicket() {
    if (Constants.userId != 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BookTicket(widget.gm!);
          },
        ),
      );
    } else {
      //Constants.showMessage(context, "Please Login to make any bookings");
      showError();
    }
  }

  void navLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SignIn();
    }));
  }

  void navRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  void showError() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: ListTile(
                tileColor: Colors.transparent,
                //onTap: showCamera,
                leading: const Icon(
                  Icons.notification_important,
                  size: 42,
                  color: redColor,
                ),
                title: MyText(
                  text: "You Are Not logged In",
                  color: Colors.black,
                  weight: FontWeight.w600,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              actions: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                        "login".tr(),
                        //'Register',
                        greenishColor,
                        greenishColor,
                        whiteColor,
                        20,
                        navLogin,
                        Icons.add,
                        whiteColor,
                        false,
                        2,
                        'Raleway',
                        FontWeight.w600,
                        18),
                    Container(
                      color: transparentColor,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "dontHaveAnAccount?".tr(),
                                    style: const TextStyle(
                                        color: bluishColor, fontSize: 16)),
                                // TextSpan(
                                //   text: "register".tr(),
                                //   style: const TextStyle(
                                //       fontWeight: FontWeight.bold, color: whiteColor),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Button(
                          "register".tr(),
                          greenishColor,
                          greenishColor,
                          whiteColor,
                          20,
                          navRegister,
                          Icons.add,
                          whiteColor,
                          false,
                          2,
                          'Raleway',
                          FontWeight.w600,
                          20),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ));
  }

  void plan() {
    if (Constants.userId != 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BookTicket(
              widget.gm!,
              show: true,
            );
          },
        ),
      );
    } else {
      //Constants.showMessage(context, "Please Login to make any bookings");
      showError();
    }
  }

  void addFav() async {
    setState(() {
      favourite = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/add_favourite"), body: {
        'user_id': Constants.userId.toString(), //"27",
        'service_id': widget.gm!.serviceId.toString(),
      });
      if (response.statusCode == 200) {
        cancel();
        message("Adventure has been added to your favourites");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void launchURL() async {
    const url = 'https://adventuresclub.net/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: 0,
                expandedHeight: 300,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            PageView.builder(
                                // reverse: true,
                                controller: _pageViewController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _activePage = index;
                                  });
                                },
                                itemCount: widget.gm!.images.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      // borderRadius: const BorderRadius.only(
                                      //     bottomLeft: Radius.circular(50)),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey.withOpacity(0.2),
                                              BlendMode.darken),
                                          image:
                                              // const ExactAssetImage(
                                              //     'images/River-rafting.png'),
                                              // fit: BoxFit.cover,
                                              NetworkImage(
                                            "${"${Constants.baseUrl}/public/uploads/"}${widget.gm!.images[index].imageUrl}",
                                          ),
                                          fit: BoxFit.fill
                                          // const ExactAssetImage(
                                          //     'images/River-rafting.png'),
                                          //fit: BoxFit.cover),
                                          ),
                                    ),
                                  );
                                }),
                            Positioned(
                              top: 20,
                              right: 15,
                              child: GestureDetector(
                                onTap: addFav,
                                child: favourite
                                    ? Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                          color: redColor,
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                          color: whiteColor,
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 15,
                              child: GestureDetector(
                                onTap: cancel,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 40,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              widget.gm!.images.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    _pageViewController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: CircleAvatar(
                                    radius: 6.5,
                                    backgroundColor: _activePage == index
                                        ? const Color.fromARGB(255, 202, 122, 2)
                                        : whiteColor,
                                    child: CircleAvatar(
                                        radius:
                                            _activePage != index ? 4.5 : 5.5,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: _activePage == index
                                            ? Colors.orange
                                            : transparentColor
                                                .withOpacity(0.1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          }),
          body: NewDetailsTab(
            widget.gm!,
            show: true,
          ),
          // children: [

          //   Expanded(child: NewDetailsTab(widget.gm!)),
          // ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.gm!.sPlan == 2
              ? future
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonIconLess('planFuture'.tr(), greenishColor,
                            whiteColor, 2, 17, 12, plan),
                      ],
                    )
                  : ButtonIconLess('bookNow'.tr(), greenishColor, whiteColor, 2,
                      17, 12, goToBookTicket)
              : GestureDetector(
                  onTap: plan,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: bluishColor,
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: MyText(
                        text: 'planFuture'.tr(),
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       ButtonIconLess('Plan For Future', greenishColor, whiteColor,
          //           1.2, 17, 12, goToBookTicket),
          //     ],
          //   ),
        ),
      ),
    );
  }
}
