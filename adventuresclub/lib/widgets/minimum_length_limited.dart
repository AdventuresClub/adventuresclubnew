import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MinLengthLimitingTextInputFormatter extends TextInputFormatter {
  final int minLength;

  MinLengthLimitingTextInputFormatter(this.minLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length >= minLength) {
      Text("${"Minimum Letters Shoule be"} $minLength");
      return newValue;
    } else if (oldValue.text.length >= minLength && newValue.text.isEmpty) {
      // Allow deletion if the length is above minimum and user deletes characters
      return newValue;
    }
    // Allow editing if the length is below minimum but not empty
    if (oldValue.text.length < minLength && newValue.text.length < minLength) {
      return oldValue;
    }
    return newValue;

    //   if (newValue.text.length >= minLength) {
    //     //Text("${"Minimum Letters Shoule be"} $minLength");
    //     return newValue;
    //   }
    //   return oldValue.copyWith(
    //       text: newValue.text
    //           .padRight(minLength, newValue.text[newValue.text.length - 1]));
    // }
  }
}
