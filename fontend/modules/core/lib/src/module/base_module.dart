import 'package:flutter/cupertino.dart';

abstract class BaseModule{
  BaseModule();
  List<LocalizationsDelegate<dynamic>> get locallizationsDelegates;
  Future<void> inject();
}