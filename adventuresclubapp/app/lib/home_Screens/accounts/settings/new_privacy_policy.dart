import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class NewPrivacyPolicy extends StatefulWidget {
  const NewPrivacyPolicy({super.key});

  @override
  State<NewPrivacyPolicy> createState() => _NewPrivacyPolicyState();
}

class _NewPrivacyPolicyState extends State<NewPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyText(
                text: "Personal Contact Informtation",
                weight: FontWeight.bold,
                size: 16,
                color: greenishColor,
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                  color: blackColor,
                  text:
                      "Adventures-club may collect the following information from users of our site: contact numbers, user name, e-mail address, GPS location (mobile site) (collectively, Personally Identifiable Information or PII). In addition, Adventures-club may collect information regarding Adventures-club account holders' past Adventures-club bookings, favorite tour-operators and aservices , customer service inquiries, service/tour-operator reviews and certain social networking preferences (e.g. pages you Like or Recommend). Adventures-club also uses web analytics software to track and analyze traffic on the site in connection with Adventures-club advertising and promotion of Adventures-club services. Adventures-club may publish these statistics or share them with third parties without including PII. Non-Personally Identifiable Information (or Non-PII) is aggregated information, demographic information and any other information that does not reveal your specific identity. We and our third party service providers may collect Non-PII from you, including your MAC address, your computer type, screen resolution, OS version, Internet browser and demographic data, for example your location, gender and date of birth and we may aggregate PII in a manner such that the end-product does not personally identify you or any other user of the Site, for example, by using PII to calculate the percentage of our users who have a particular telephone area code. We and our third party service providers may also use cookies, pixel tags, web beacons, and other similar technologies to better serve you with more tailored information and facilitate your ongoing use of our Site. If you do not want information collected through the use of cookies, there is a simple procedure in most browsers that allows you to decline the use of cookies. To learn more about cookies, please visit http://www.allaboutcookies.org/. IP Addresses are the Internet Protocol addresses of the computers that you are using. Your IP Address is automatically assigned to the computer that you are using by your Internet Service Provider (ISP). This number is identified and logged automatically in our server log files whenever users visit the Site, along with the time(s) of such visit(s) and the page(s) that were visited. Collecting IP Addresses is standard practice on the Internet and is done automatically by many websites")
            ],
          ),
        ),
      ),
    );
  }
}
