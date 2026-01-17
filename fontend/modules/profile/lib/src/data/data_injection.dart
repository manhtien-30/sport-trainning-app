import 'package:core/libs.dart';
import '../../profile.dart';
import '../domain/profile_repository.dart';
import '../data/profile_repository_imp.dart';

class ProfileDataInjection {
  Future<void> inject() async {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<ProfileRepository>()) {
      getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImp(),
      );
    }
  }
}
