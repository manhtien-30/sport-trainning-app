import 'package:flutter/cupertino.dart';

abstract class BaseModules {
  const BaseModules();

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates;

  void initEnv();

  Future<void> inject();
}
