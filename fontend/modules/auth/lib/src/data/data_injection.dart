import 'package:auth/src/auth-controller.dart';
import 'package:auth/src/data/auth_repo_imp.dart';
import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/presentation/bloc/auth_bloc.dart';
import 'package:core/libs.dart';

class AuthDataInjection {
  Future<void> inject() async {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<AuthenticationRepository>()) {
      getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImp(),
      );
    }

    // Bloc typically created per usage; register a factory
    if (!getIt.isRegistered<AuthBloc>()) {
      getIt.registerFactory<AuthBloc>(
        () => AuthBloc(getIt.get<AuthenticationRepository>()),
      );
    }

    // Optional controller for presentation layer coordination
    if (!getIt.isRegistered<AuthenticationController>()) {
      getIt.registerLazySingleton<AuthenticationController>(
        () => AuthenticationController(),
      );
    }
  }
}
