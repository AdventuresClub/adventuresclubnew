import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/settings/new_privacy_policy.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/about_us_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Map mapAimedFilter = {};
  AboutUsModel about = AboutUsModel(0, "", "", "", "", "");

  @override
  void initState() {
    super.initState();
    aboutUs();
  }

  void aboutUs() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/about-us"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      dynamic result = mapAimedFilter['data'];
      AboutUsModel au = AboutUsModel(
        int.tryParse(result['id'].toString()) ?? 0,
        result['image'] ?? "",
        result['content'] ?? "",
        result['created_at'] ?? "",
        result['updated_at'] ?? "",
        result['deleted_at'] ?? "",
      );
      setState(() {
        about = au;
      });
    }
  }

  void navPrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewPrivacyPolicy();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MyText(
            text: 'aboutUs',
            color: greenishColor,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: greenishColor),
          backgroundColor: whiteColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: ExactAssetImage('images/logo.png'),
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MyText(
                      text: about
                          .content, //'We offer a wide variety of fun adventure tours in Oman for all ages, customized to fit your interests and skills. We also offer variety adventure training.',
                      align: TextAlign.center,
                      color: greyColor,
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ExpansionTile(
                      leading: const Icon(Icons.policy),
                      childrenPadding: const EdgeInsets.all(12),
                      title: Text(
                        "privacyPolicy".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        MyText(
                            color: blackColor,
                            text:
                                "Adventures-club may collect the following information from users of our site: contact numbers, user name, e-mail address, GPS location (mobile site) (collectively, Personally Identifiable Information or PII). In addition, Adventures-club may collect information regarding Adventures-club account holders' past Adventures-club bookings, favorite tour-operators and aservices , customer service inquiries, service/tour-operator reviews and certain social networking preferences (e.g. pages you Like or Recommend). Adventures-club also uses web analytics software to track and analyze traffic on the site in connection with Adventures-club advertising and promotion of Adventures-club services. Adventures-club may publish these statistics or share them with third parties without including PII. Non-Personally Identifiable Information (or Non-PII) is aggregated information, demographic information and any other information that does not reveal your specific identity. We and our third party service providers may collect Non-PII from you, including your MAC address, your computer type, screen resolution, OS version, Internet browser and demographic data, for example your location, gender and date of birth and we may aggregate PII in a manner such that the end-product does not personally identify you or any other user of the Site, for example, by using PII to calculate the percentage of our users who have a particular telephone area code. We and our third party service providers may also use cookies, pixel tags, web beacons, and other similar technologies to better serve you with more tailored information and facilitate your ongoing use of our Site. If you do not want information collected through the use of cookies, there is a simple procedure in most browsers that allows you to decline the use of cookies. To learn more about cookies, please visit http://www.allaboutcookies.org/. IP Addresses are the Internet Protocol addresses of the computers that you are using. Your IP Address is automatically assigned to the computer that you are using by your Internet Service Provider (ISP). This number is identified and logged automatically in our server log files whenever users visit the Site, along with the time(s) of such visit(s) and the page(s) that were visited. Collecting IP Addresses is standard practice on the Internet and is done automatically by many websites")
                      ],
                    ),
                  ),
                  //const SizedBox(height: 5),
                  // Card(
                  //   child: ExpansionTile(
                  //     leading: const Icon(Icons.info),
                  //     childrenPadding: const EdgeInsets.all(12),
                  //     title: const Text(
                  //       "Use Your Information",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     children: [
                  //       MyText(
                  //           color: blackColor,
                  //           text:
                  //               "Adventures-club uses PII to create users' Adventures-club accounts, to communicate with users about Adventures-club services, to offer users additional services, promotions and special offers and to charge for purchases made through Adventures-club. Users may affirmatively opt-out of receiving promotional communications from Adventures-club by visiting https://Adventuresclub.net. Personal account page and providing Adventures-club with their e-mail address via the opt-out link. Adventures-club may also use PII to enforce Adventures-club terms of use and service. Adventures-club uses cookies to remember users on the site and to enhance users' experience on the site. For example, when users with Adventures-club accounts return to the site, cookies identify those users and allow the site to provide certain user-specific information such as Adventures-club login information, choice of website language and country selection in addition to any other information we might collect in the future. Adventures-club does not sell the information it collects to third parties. Adventures-club shares collected PII to third-party operators and service providers with whom Adventures-club works to provide application programming interfaces (APIs) and other functions for the site in connection with the delivery of Adventures-club services. In addition, Adventures-club shares users' Adventures-club booking content, special booking instructions, first and last name, street address and telephone number with tour-operators and aservices where users' bookings are placed to the extent necessary to process those bookings. Adventures-club may also disclose PII to third parties such as attorneys, collection agencies, tribunals or law enforcement authorities pursuant to valid requests in connection with alleged violations of Adventures-club terms of use and service or other alleged contract violations, infringement or similar harm to persons or property. User generated content posted through the site such as service/tour-operator reviews and certain social networking preferences (e.g. pages you Like or Recommend) may be viewed by the general public. Accordingly, Adventures-club cannot ensure the privacy of any PII included in such user generated content. Non-Personally Identifiable Information. Because Non-PII does not personally identify you, we may use such information for any purpose. In addition, we reserve the right to share such Non PII, which does not personally identify you, with our affiliates and with other third parties, for any purpose. In some instances, we may combine Non-PII with PII (such as combining your name with your geographical location). If we do combine any Non-PII with PII, the combined information will be treated by us as PII hereunder as long as it is so combined. IP Addresses. We use IP addresses for purposes such as calculating site usage levels, helping diagnose server problems, and administering the site. We may also use and disclose IP Addresses for all the purposes for which we use and disclose PII. Please note that we treat IP Addresses, server log files and related information as Non-PII, except where we are required to do otherwise under applicable law.")
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: ExpansionTile(
                  //     leading: const Icon(Icons.email),
                  //     childrenPadding: const EdgeInsets.all(12),
                  //     title: const Text(
                  //       "Your Email Address",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     children: [
                  //       MyText(
                  //           color: blackColor,
                  //           text:
                  //               "To register for an account, we require you to supply us with your email address, or other information needed to contact you online and over the phone. We use your e-mail address and other contact information you provide us with to confirm your booking and to communicate with you in case of an booking problem, so one cannot register without an e-mail address. If you supply us with your email address, you may later access it, update it, modify it and delete any inaccuracies by accessing your account through my account information link on the user main page. You may also choose simply not to provide us with your email address; however you will not be able to register on the website and place bookings. We communicate part of your contact information (name, surname, booking delivery address and phone number) with the member tour-operator from which you have placed an booking. We also use this information to facilitate and improve your use of the website, to communicate with you, for internal purposes and to comply with any requirements of law. This information may be disclosed to our staff and to third parties involved in the delivery of your booking or the analysis and support of your use of the website. We do not sell and will not divulge your personal contact information to third parties other than as specified in this Privacy Policy without your permission unless we are legally entitled or obliged to do so (for example, if required to do so by Court booking or for the purposes of prevention of fraud or other crime).")
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: ExpansionTile(
                  //     leading: const Icon(Icons.credit_card),
                  //     childrenPadding: const EdgeInsets.all(12),
                  //     title: const Text(
                  //       "ATM, Credit Cards & Payment Information",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     children: [
                  //       MyText(
                  //           color: blackColor,
                  //           text:
                  //               "When you place an booking through the website, you are required to select a method of payment. Adventures-club is not interested in your debit/credit card information nor do store any of your debit/credit information, since bookings could be paid at the door directly to the tour-operator through methods of payment such as cash, credit card or payment checks. Online debit/ credit card payment is also an option and for some tour-operators and aservices it can be the only method of payment. For transactions with online debit/credit cards, we transmit your entire card information to the appropriate debit/credit card company in an encrypted format with globally accepted rules and applications during booking processing. Upon your choice, we keep a part of your card information in an encrypted format, taking precaution to maintain physical, electronic and procedural safeguards over your credit card information.")
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: ExpansionTile(
                  //     leading: const Icon(Icons.info),
                  //     childrenPadding: const EdgeInsets.all(12),
                  //     title: const Text(
                  //       "Booking placement information",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     children: [
                  //       MyText(
                  //           color: blackColor,
                  //           text:
                  //               "Personal information required during the booking process includes name, address, phone number, email address and other similar information used to identify you and complete an booking. Personal information collected at our site will be shared with a tour-operator when processing your booking. We have an agreement with all member tour-operators and aservices , restricting disclosure or further processing of personal information provided to them by us. Your personal information will be used to notify you of your booking status. Personal information will not be shared with any of our business partners or affiliates without your permission. It is treated as confidential, and will not be disclosed to outside parties, unless compelled by applicable legislation. We only send marketing emails to those people who have specifically requested to receive this information.")
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
