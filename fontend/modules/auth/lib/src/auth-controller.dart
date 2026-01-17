import 'dart:async';

import 'package:auth/src/domain/authentication_repository.dart';
import 'package:core/libs.dart';
import 'package:flutter/widgets.dart';

/// Controls navigation based on authentication status.
///
/// Usage with GoRouter (in your app router):
///   final authController = GetIt.I<AuthenticationController>();
///   GoRouter(
///     refreshListenable: authController, // rebuild on auth changes
///     redirect: authController.redirect, // centralize auth redirects
///     ...
///   );
class AuthenticationController extends ChangeNotifier {
  AuthenticationController()
      : _authRepository = GetIt.instance.get<AuthenticationRepository>() {
    // Subscribe to auth status changes and notify listeners for GoRouter refresh.
    _subscription = _authRepository.status.listen((status) {
      _lastStatus = status;
      notifyListeners();
    });
  }

  final AuthenticationRepository _authRepository;
  late final StreamSubscription<AuthenticationStatus> _subscription;
  AuthenticationStatus _lastStatus = AuthenticationStatus.unknown;

  AuthenticationStatus get status => _lastStatus;

  bool get isAuthenticated => _lastStatus == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => _lastStatus == AuthenticationStatus.unauthenticated;

  /// GoRouter redirect logic.
  /// Returns a path to redirect to, or null to stay on current location.
  String? redirect(BuildContext context, GoRouterState state) {
    final String location = state.uri.toString();

    // Allow splash or unknown state to proceed without redirects.
    if (_lastStatus == AuthenticationStatus.unknown) return null;

    const String loginPath = '/login';
    const String signUpPath = '/signup';

    if (isUnauthenticated) {
      // Allow unauthenticated users to access login and signup pages.
      if (location == loginPath || location == signUpPath) return null;
      // Otherwise, redirect to login.
      return loginPath;
    }

    // If the user is logged in and tries to go to login or signup, send them home.
    if (isAuthenticated && (location == loginPath || location == signUpPath)) {
      return '/home';
    }

    return null;
  }

  /// Imperative helpers (optional):
  void goToLogin(BuildContext context) => GoRouter.of(context).go('/login');
  void goToHome(BuildContext context) => GoRouter.of(context).go('/home');

  Future<void> logoutAndRedirect(BuildContext context) async {
    await _authRepository.logout();
    goToLogin(context);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}