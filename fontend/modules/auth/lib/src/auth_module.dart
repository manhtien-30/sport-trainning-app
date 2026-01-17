import 'package:core/src/module/base_module.dart';
import 'package:flutter/widgets.dart';
import 'data/data_injection.dart';
import 'presentation/localization/generated/app_localizations.dart';

part 'auth_module_impl.dart';

abstract class AuthModule extends BaseModule {
  static final AuthModule _instance = _AuthModuleImpl();

  static AuthModule get instance => _instance;
}
