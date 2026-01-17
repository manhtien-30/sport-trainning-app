abstract class LocalService{
  final String prefBox = "AuthCache";
  final String keyAccessToken = "AccessToken";
  final String keyRefreshToken = "RefreshToken";
  final String keyTokenExpiry = "TokenExpiry"; // epoch millis

  Future<void> initialize();

  String? get accessToken;

  String? get refreshToken;

  int? get tokenExpiryMillis;

  Future<void> saveAccessToken(String accessToken);

  Future<void> saveRefreshToken(String refreshToken);

  Future<void> saveTokenExpiryMillis(int expiryMillis);
}