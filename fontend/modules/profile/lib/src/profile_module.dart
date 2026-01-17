import 'package:core/src/module/base_module.dart';
import 'package:flutter/widgets.dart';
import 'data/data_injection.dart';

part 'profile_module_impl.dart';

abstract class ProfileModule extends BaseModule {
  static final ProfileModule _instance = _ProfileModuleImpl();

  static ProfileModule get instance => _instance;
}
