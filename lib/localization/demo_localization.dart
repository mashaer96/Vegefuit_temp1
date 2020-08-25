import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  // String getTranslatedDescription(String key) {
  //   return Product.priceDescriptionAr;
  // }

  // String getTranslatedTitle(String key) {
  //   return _localizedValues[key];
  // }  

  static const LocalizationsDelegate<DemoLocalizations> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations localization = new DemoLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;  
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalizations.of(context).getTranslatedValue(key);
}

// String getTranslated(BuildContext context, String key) {
//   return DemoLocalizations.of(context).getTranslatedValue(key);
// }

const String ARABIC = 'ar';
const String ENGLISH = 'en';

const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ARABIC:
      _temp = Locale(languageCode, 'SA');
      break;
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    default:
      _temp = Locale(ARABIC, 'SA');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ARABIC;
  return _locale(languageCode);
}
