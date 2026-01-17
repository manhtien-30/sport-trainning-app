import 'package:frontend/presentation/app.dart';

import 'environment/App_environment.dart';
import 'environment/environment.dart';

void main() {
  FlavorConfig.initValue([AppEnv.dev, AppEnv.staging],
      canAccessDevelopmentMode: true);
  startApp();
}
