// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizationImp {
  AppLocalizationImp();

  static AppLocalizationImp? _current;

  static AppLocalizationImp get current {
    assert(
      _current != null,
      'No instance of AppLocalizationImp was loaded. Try to initialize the AppLocalizationImp delegate before accessing AppLocalizationImp.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizationImp> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizationImp();
      AppLocalizationImp._current = instance;

      return instance;
    });
  }

  static AppLocalizationImp of(BuildContext context) {
    final instance = AppLocalizationImp.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizationImp present in the widget tree. Did you add AppLocalizationImp.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizationImp? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizationImp>(context, AppLocalizationImp);
  }

  /// `chao`
  String get sada {
    return Intl.message('chao', name: 'sada', desc: '', args: []);
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizationImp> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizationImp> load(Locale locale) =>
      AppLocalizationImp.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
