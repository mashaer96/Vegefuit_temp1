import 'package:flutter/material.dart';

  bool isArabic(context) {
    String myLocale = Localizations.localeOf(context).toString();
    bool isArabic;
    if (myLocale == 'ar_SA') {
      isArabic = true;
    } else {
      isArabic = false;
    }
    return isArabic;
  }

