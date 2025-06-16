// import 'package:flutter/services.dart';

// class NoSpaceFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Check if the new value contains any spaces
//     if (newValue.text.contains(' ')) {
//       // If it does, return the old value
//       return oldValue;
//     }
//     // Otherwise, return the new value
//     return newValue;
//   }
// }

// import 'package:flutter/services.dart';

// class NoSpaceFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Check if this is a paste operation (either by length difference or selection change)
//     final isPaste = newValue.text.length - oldValue.text.length > 1 ||
//         newValue.selection.baseOffset != newValue.selection.extentOffset ||
//         (oldValue.selection.isCollapsed && !newValue.selection.isCollapsed);

//     if (isPaste) {
//       // Remove all spaces from pasted content
//       final newText = newValue.text.replaceAll(' ', '');
//       return TextEditingValue(
//         text: newText,
//         selection: TextSelection.collapsed(offset: newText.length),
//       );
//     }

//     // For single character input, block spaces
//     if (newValue.text.endsWith(' ')) {
//       return oldValue;
//     }

//     // Allow normal typing of non-space characters
//     return newValue;
//   }
// }

import 'package:flutter/services.dart';

class NoSpaceFormatter extends TextInputFormatter {
  final bool trim;

  NoSpaceFormatter({this.trim = false});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text.replaceAll(' ', '');

    if (trim) {
      newText = newText.trim();
    }

    // Only return modified value if something changed
    if (newText != newValue.text) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}
