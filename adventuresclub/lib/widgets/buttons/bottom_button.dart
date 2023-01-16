
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/my_button.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({
    Key? key,
    this.onTap,
    this.buttonText = 'Continue',
    this.bgColor,
  }) : super(key: key);
  final String? buttonText;
  final VoidCallback? onTap;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      color: bgColor ?? bluishColor,
      child: SizedBox(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              onPressed: onTap,
              buttonText: buttonText,
              marginLeft: 60,
              marginRight: 60,
            ),
          ],
        ),
      ),
    );
  }
}
