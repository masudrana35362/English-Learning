
import 'package:fluttertoast/fluttertoast.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension EmailValidateExtension on String {
  bool get validateEmail {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailReg.hasMatch(this);
  }

  bool get validatePhoneNumber {
    final phoneReg = RegExp(r"^(?:\+?88)?01[3-9]\d{8}$");
    return phoneReg.hasMatch(this);
  }
}

extension ShowToastExtension on String {
  showToast({bc, tc}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: this,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bc,
        textColor: tc ,
        fontSize: 16.0);
  }
}


extension CapitalizeWordsExtension on String {
  String get capitalizeWords {
    if (isEmpty) {
      return '';
    }

    List<String> words = split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalized = word[0].toUpperCase() + word.substring(1);
        capitalizedWords.add(capitalized);
      }
    }

    return capitalizedWords.join(' ');
  }
}
