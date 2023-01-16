import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

AppBar appBar({
  BuildContext? context,
  bool? haveBackIcon = false,
  VoidCallback? onBackIconTap,
  String? text,
}) {
  return AppBar(
    backgroundColor: whiteColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 1.5,
    leading: haveBackIcon!
        ? IconButton(
            onPressed: onBackIconTap ?? () => Navigator.pop(context!),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          )
        : const SizedBox(),
    title: MyText(text: text,color: bluishColor,weight: FontWeight.w400,)
  );
}
