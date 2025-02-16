import 'package:app/constants.dart';
import 'package:app/new_signup/new_register.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/sign_up/sign_in.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NullUserContainer extends StatefulWidget {
  const NullUserContainer({super.key});

  @override
  State<NullUserContainer> createState() => _NullUserContainerState();
}

class _NullUserContainerState extends State<NullUserContainer> {
  void navSignIn() {
    context.push('/signIn');

    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const SignIn();
    // }));
  }

  void changeIndex() {
    Provider.of<NavigationIndexProvider>(context, listen: false).homeIndex = 0;
  }

  void navLogin() {
    navSignIn();
    changeIndex();
  }

  void navRegister() {
    Provider.of<NavigationIndexProvider>(context, listen: false).homeIndex = 0;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Icon(
                  Icons.notification_important,
                  color: bluishColor,
                  size: 80,
                ),
                // Image.asset(
                //   'images/appLogo.png',
                //   height: 200,
                //   width: 320,
                // ),
                const SizedBox(
                  height: 20,
                ),
                MyText(
                  text: "You Are Not logged In",
                  weight: FontWeight.w600,
                  color: blackColor,
                  size: 22,
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                // ListTile(
                //   tileColor: Colors.transparent,
                //   //onTap: showCamera,
                //   // leading: const Icon(
                //   //   Icons.notification_important,
                //   //   color: bluishColor,
                //   // ),
                //   title: MyText(
                //     text: "You Are Not logged In",
                //     weight: FontWeight.w600,
                //     color: blackColor,
                //     size: 16,
                //   ),
                //   trailing: const Icon(Icons.chevron_right_rounded),
                // ),
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

                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: transparentColor,
                      height: 40,
                      child: GestureDetector(
                        onTap: navRegister,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "dontHaveAnAccount?".tr(),
                                    style: const TextStyle(
                                        color: bluishColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
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
                      padding: const EdgeInsets.only(bottom: 20),
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
            ),
          ),
        ],
      ),
    );
  }
}
