import 'package:core/src/data/data_injection.dart';
import 'package:core/src/evironment.dart';
import 'package:core/src/module/base_module.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:flutter/src/widgets/localizations.dart';
export 'evironment.dart';
export 'module/base_module.dart';

part 'core_module_impl.dart';

abstract class CoreModule extends BaseModule {
  static final CoreModule _instance = _CoreModuleImpl();

  static CoreModule newInstance({required CoreEnvironment coreEnvironment}) {
    GetIt.instance.registerSingleton<CoreEnvironment>(coreEnvironment);
    return _instance;
  }

  static CoreModule get instance {
    final isRegisEnv = GetIt.instance.isRegistered<CoreEnvironment>();
    if (!isRegisEnv) throw Exception("environment not set");
    return _instance;
  }
}
