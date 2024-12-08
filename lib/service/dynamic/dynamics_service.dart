import 'package:flutter/material.dart';
import 'package:english_learning/customizations.dart' as cus;

class DynamicsService with ChangeNotifier {
  bool onceRebuilt = false;

  Color get primaryColor => cus.primaryColor;
  Color get whiteColor => cus.whiteColor;
  Color get blackColor => cus.blackColor;
  Color get hintColor => cus.hintColor;
  Color get borderColor => cus.borderColor;
  Color get secondaryColor => cus.secondaryColor;
  Color get redColor => cus.redColor;
  Color get greenColor => cus.greenColor;
  Color get yellowColor => cus.yellowColor;
  bool _noConnection = false;

  statusColor(String status) {
    if (status == "complete") {
      return greenColor;
    }
    if (status == "pending") {
      return yellowColor;
    }
    return black60;
  }

  String languageSlug = 'en_GB';
  bool currencyRight = false;
  bool textDirectionRight = false;
  String currencySymbol = "\$";
  String currencyCode = "USD";

  bool get noConnection => _noConnection;
  get appLocal =>
      Locale(languageSlug.substring(0, 2), languageSlug.substring(3));

  List get primaryGridColors => cus.primaryGridColors;

  Color get black01 => blackColor.withOpacity(.01);
  Color get black05 => blackColor.withOpacity(.05);
  Color get black10 => blackColor.withOpacity(.10);
  Color get black20 => blackColor.withOpacity(.20);
  Color get black40 => blackColor.withOpacity(.40);
  Color get black60 => blackColor.withOpacity(.60);
  Color get black70 => blackColor.withOpacity(.70);
  Color get black80 => blackColor.withOpacity(.80);

  Color get primary05 => primaryColor.withOpacity(.05);
  Color get primary10 => primaryColor.withOpacity(.10);
  Color get primary20 => primaryColor.withOpacity(.20);
  Color get primary40 => primaryColor.withOpacity(.40);
  Color get primary60 => primaryColor.withOpacity(.60);
  Color get primary70 => primaryColor.withOpacity(.70);
  Color get primary80 => primaryColor.withOpacity(.80);

  getColors() async {
    if (onceRebuilt) return;
    onceRebuilt = true;

    languageSlug =  "en_GB";
    currencyRight = false;
    currencySymbol = "৳";
    currencyCode = "BDT";
    textDirectionRight = false;

    /*final responseData =
        await NetworkApiServices().getApi(AppUrls.currencyLanguageUrl, null);
    if (responseData != null) {
      languageSlug = responseData["language"]?["slug"] ?? "en_GB";
      currencyRight = responseData["currencyPosition"] != "left";
      currencySymbol = responseData["symbol"] ?? "\$";
      currencyCode = responseData["currency_code"] ?? "USD";
      textDirectionRight = responseData["rtl"] is String
          ? double.parse(responseData["rtl"])
          : responseData["rtl"];
    }*/
    notifyListeners();
  }

  setNoConnection(value) {
    if (value == noConnection) {
      return;
    }
    _noConnection = value;
    notifyListeners();
  }
}