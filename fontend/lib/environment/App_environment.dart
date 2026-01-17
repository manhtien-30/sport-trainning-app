import 'package:frontend/environment/environment.dart';

import '../modules/app_modules.dart';

class AppEnv extends Environment {
  AppEnv._({
    required super.name,
    required super.baseUrl,
    required super.modules,
  });

  static final dev = AppEnv._(
    name: 'development',
    baseUrl: "http://192.168.1.227:8080/api",
    modules: AppModules(),
  );
  static final staging = AppEnv._(
    name: "staging",
    baseUrl: "http://192.168.1.227:8080/api",
    modules: AppModules(),
  );
}
