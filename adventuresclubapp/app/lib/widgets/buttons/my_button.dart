import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    this.buttonText,
    this.onPressed,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginRight = 0.0,
    this.marginLeft = 0.0,
  }) : super(key: key);
  String? buttonText;
  VoidCallback? onPressed;
  double? marginLeft, marginRight, marginTop, marginBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginLeft!,
        right: marginRight!,
        top: marginTop!,
        bottom: marginBottom!,
      ),
      child: MaterialButton(
        height: 50,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: bluishColor,
        onPressed: onPressed,
        child: Center(
          child: MyText(
            text: '$buttonText'.tr(),
            size: 16,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
