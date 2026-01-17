import 'package:core/core.dart';
import 'package:core/src/data/network/layer/network_creator.dart';

class DataInjection {
  Future<void> inject(CoreEnvironment env) async {
    final getIt = GetIt.instance;
    getIt.registerSingleton<BaseOptions>(BaseOptions(baseUrl: env.baseUrl));
    getIt.registerSingleton<Dio>(Dio(getIt.get<BaseOptions>()));
  }
}