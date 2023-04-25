import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/text_fields/no_space.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = "";
  String email = "";
  String phone = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    setState(() {
      name = Constants.profile.name;
      phone = Constants.profile.mobile;
      email = Constants.profile.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Column(
              children: [
                TextFields(name, nameController, 15, greyProfileColor, true),
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
                ),
                TextField(
                  inputFormatters: [NoSpaceFormatter()],
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  controller: phoneController,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                  ),
                  onChanged: (val) {
                    final trimVal = val.trim();
                    if (val != trimVal) {
                      setState(() {
                        phoneController.text = trimVal;
                        phoneController.selection = TextSelection.fromPosition(
                            TextPosition(offset: trimVal.length));
                      });
                    }
                  },
                  decoration: InputDecoration(
                      suffixText: "Send OTP",
                      suffixStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      hintText: phone,
                      hintStyle: TextStyle(
                          color: blackColor.withOpacity(
                            0.6,
                          ),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Raleway'),
                      hintMaxLines: 1,
                      isDense: true,
                      filled: true,
                      fillColor: greyProfileColor,
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: blackColor.withOpacity(0.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: blackColor.withOpacity(0.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: blackColor.withOpacity(0.0)))),
                ),
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
                ),
                TextFields(email, emailController, 15, greyProfileColor, true),
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
                ),
                const SizedBox(
                  height: 30,
                ),
                Button(
                    'Save',
                    greenishColor,
                    greenishColor,
                    whiteColor,
                    18,
                    () {},
                    Icons.add,
                    whiteColor,
                    false,
                    1.3,
                    'Raleway',
                    FontWeight.w600,
                    16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
