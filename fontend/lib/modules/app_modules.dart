import 'dart:core';

import 'package:core/core.dart';
import 'package:flutter/src/widgets/localizations.dart';
import 'package:order/order.dart';
import 'package:auth/auth.dart';
import 'package:profile/profile.dart';
import 'package:payment/payment.dart';

import 'base_modules.dart';

class AppModules extends BaseModules {
  AppModules();

  final List<BaseModule> modules = [];

  // dang kí module moi tai day
  @override
  void initEnv() {
    modules.addAll([
      CoreModule.newInstance(coreEnvironment: CoreEnvironment(baseUrl: "http://192.168.1.227:8080/api")),
      AuthModule.instance,
      OrderModule.instance,
      ProfileModule.instance,
      PaymentModule.instance,
    ]);
  }

  @override
  Future<void> inject() async {
    await Future.wait(modules.map((e) => e.inject()).toList());
  }

  @override
  List<LocalizationsDelegate> get localizationsDelegates => [
    // Include delegates from modules that provide localizations
    ...AuthModule.instance.locallizationsDelegates,
    ...ProfileModule.instance.locallizationsDelegates,
    ...PaymentModule.instance.locallizationsDelegates,
  ];
}
