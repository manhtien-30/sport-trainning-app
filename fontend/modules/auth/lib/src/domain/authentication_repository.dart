import 'user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
enum Roles { admin, user }

abstract class AuthenticationRepository {
  // Currently authenticated user shared across the app; null if not logged in or expired.
  User? get currentUser;

  Stream<AuthenticationStatus> get status;

  void dispose();

  Future<bool> signIn({
    required String username,
    required String password
  });

  String? get cacheAccessToken;

  String? get cacheRefreshToken;

  Future<void> saveCacheAccessToken(String accessToken);

  Future<void> saveCacheRefreshToken(String refreshToken);

  Future<bool> signUp({
    required String username,
    required String password,
    required String email,

  });

  Future<void> logout();
}