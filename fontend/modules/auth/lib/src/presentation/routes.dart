import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/presentation/ui/screen/login_screen.dart';
import 'package:auth/src/presentation/ui/screen/signup_screen.dart';
import 'package:core/libs.dart';

class AuthRoutes {
  static const String login = '/login';
  static const String signup = '/signup';

  static GoRoute route(AuthenticationRepository repo) => GoRoute(
        path: login,
        builder: (context, state) => LoginScreen(authenticationRepository: repo),
      );

  static GoRoute signUpRoute() => GoRoute(
        path: signup,
        builder: (context, state) => const SignupScreen(),
      );
}