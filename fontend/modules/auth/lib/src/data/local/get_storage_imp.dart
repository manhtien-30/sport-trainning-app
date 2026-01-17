import 'package:auth/src/data/local/local_service.dart';
import 'package:core/libs.dart';
/// SharedPreferences-backed implementation of LocalService for simple persistence.
class StorageLocal extends LocalService {
  SharedPreferences? _prefs;

  @override
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  String? get accessToken => _prefs?.getString(keyAccessToken);

  @override
  String? get refreshToken => _prefs?.getString(keyRefreshToken);

  @override
  int? get tokenExpiryMillis => _prefs?.getInt(keyTokenExpiry);

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _prefs?.setString(keyAccessToken, accessToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _prefs?.setString(keyRefreshToken, refreshToken);
  }

  @override
  Future<void> saveTokenExpiryMillis(int expiryMillis) async {
    await _prefs?.setInt(keyTokenExpiry, expiryMillis);
  }
}