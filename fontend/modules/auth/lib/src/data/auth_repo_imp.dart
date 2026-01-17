import 'dart:async';
import 'dart:convert';

import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/domain/user.dart';
import 'package:auth/src/data/local/get_storage_imp.dart';
import 'package:core/core.dart';
import 'package:core/src/data/network/wrapper/result.dart';
import 'package:core/src/data/network/wrapper/network_errors.dart';
import 'package:flutter/foundation.dart';

import 'bean/auth_request_objects/sign_in_request.dart';
import 'bean/auth_request_objects/sign_up_request.dart';
import 'bean/auth_response_objects/sign_in_response.dart';
import 'bean/auth_response_objects/sign_up_response.dart';

class AuthenticationRepositoryImp extends AuthenticationRepository {
  AuthenticationRepositoryImp() {
    _init();
  }

  User? _currentUser;

  @override
  User? get currentUser => _currentUser;

  final dio = GetIt.instance<Dio>();
  final StorageLocal _local = StorageLocal();
  final StreamController<AuthenticationStatus> _statusController =
      StreamController<AuthenticationStatus>.broadcast();

  Future<void> _init() async {
    _statusController.add(AuthenticationStatus.unknown);
    await _local.initialize();
    // Try restore session from storage
    final token = _local.accessToken;
    final expiry = _local.tokenExpiryMillis;
    if (token != null && token.isNotEmpty && expiry != null) {
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      if (expiry > nowMs) {
        // Token still valid, create a placeholder user; details can be fetched later
        _currentUser = User(
          id: '',
          username: '',
          token: token,
          tokenExpiryMillis: expiry,
        );
        _statusController.add(AuthenticationStatus.authenticated);
        return;
      } else {
        // expired
        await _local.saveAccessToken('');
        await _local.saveTokenExpiryMillis(0);
      }
    }
    _statusController.add(AuthenticationStatus.unauthenticated);
  }


  @override
  void dispose() {
    _statusController.close();
  }

  @override
  Future<bool> signIn({required String username, required String password}) async {
    final SignInRequestClient client = SignInRequestClient(
      SignInRequestBody(username: username, password: password),
    );
    print(client.path.toString());
    final result = await NetworkExecutor.executed<SignInResponse, SignInResponse>(
      route: client,
      responseType: SignInResponse(),
    );

    return await result.map(
      success: (s) async {
        final data = s.data;
        final res = data.response;
        final token = res?.token;
        int? expiryMs;
        if (token != null && token.isNotEmpty) {
          await _local.saveAccessToken(token);
          expiryMs = _decodeJwtExpiryMillis(token);
          if (expiryMs != null) {
            await _local.saveTokenExpiryMillis(expiryMs);
          }
        }
        // Create shared user instance for app lifetime until token expiry
        _currentUser = User(
          id: res?.id ?? '',
          username: res?.username ?? '',
          email: res?.email,
          roles: res?.roles ?? const [],
          token: token ?? '',
          type: res?.type,
          lastLogin: res?.lastLogin,
          tokenExpiryMillis: expiryMs,
        );
        print(_currentUser.toString());
        _statusController.add(AuthenticationStatus.authenticated);
        return true;
      },
      failure: (f) async {
        _statusController.add(AuthenticationStatus.unauthenticated);
        _logAuthError('signIn', f.error);
        return false;
      },
    );
  }

  @override
  Future<bool> signUp({required String username, required String password, required String email}) async {
    final SignUpRequestClient client = SignUpRequestClient(
      signUpRequestBody: SignUpRequestBody(username: username, password: password, email: email),
    );

    final result = await NetworkExecutor.executed<SignUpResponse, SignUpResponse>(
      route: client,
      responseType: SignUpResponse(),
    );

    return await result.map(
      success: (s) async {
        // Do not change authentication status here; require user to login.
        return true;
      },
      failure: (f) async {
        _logAuthError('signUp', f.error);
        return false;
      },
    );
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
    // Clear tokens and expiry
    await _local.saveAccessToken('');
    await _local.saveRefreshToken('');
    await _local.saveTokenExpiryMillis(0);
    _statusController.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Stream<AuthenticationStatus> get status => _statusController.stream;

  int? _decodeJwtExpiryMillis(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return null;
      final payload = parts[1];
      // Fix base64 padding
      String normalized = base64Url.normalize(payload);
      final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized))) as Map<String, dynamic>;
      final exp = payloadMap['exp'];
      if (exp is int) {
        // exp is usually seconds since epoch
        return exp > 2000000000 ? exp : exp * 1000;
      } else if (exp is String) {
        final expInt = int.tryParse(exp);
        if (expInt != null) {
          return expInt > 2000000000 ? expInt : expInt * 1000;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  void _logAuthError(String action, NetworkError error) {
    final timestamp = DateTime.now().toIso8601String();
    error.when(
      request: (dioError) {
        final base = dioError.requestOptions.data;
        final status = dioError.response?.statusCode;
        final method = dioError.requestOptions.method;
        final path = dioError.requestOptions.path;
        final message = dioError.message;
        final responseBody = dioError.response?.data;
        debugPrint('[AUTH][$timestamp][$action] Request error: HTTP ${status ?? 'N/A'} $base $method $path - Message: ${message ?? 'Unknown'} - Response: ${responseBody ?? 'No body'}');
      },
      type: (typeError) {
        print('[AUTH][$timestamp][$action] Decoding/Type error: ${typeError ?? 'Unknown type error'}');
      },
      connectivity: (msg) {
        print('[AUTH][$timestamp][$action] Connectivity error: ${msg ?? 'No connection'}');
      },
    );
  }

  @override
  String? get cacheAccessToken => _local.accessToken;

  @override
  String? get cacheRefreshToken => _local.refreshToken;

  @override
  Future<void> saveCacheAccessToken(String accessToken) async {
    await _local.saveAccessToken(accessToken);
  }

  @override
  Future<void> saveCacheRefreshToken(String refreshToken) async {
    await _local.saveRefreshToken(refreshToken);
  }
}