import 'package:core/core.dart';
import 'package:auth/auth.dart';

class GetProfileRequest extends BaseClientGenerator {
  GetProfileRequest();

  @override
  String get baseURL => GetIt.instance.get<CoreEnvironment>().baseUrl;

  @override
  dynamic get body => null;

  @override
  Map<String, dynamic> get header {
    final auth = GetIt.instance.get<AuthenticationRepository>();
    final token = auth.currentUser?.token;
    final type = auth.currentUser?.type ?? 'Bearer';
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': '$type $token',
    };
  }

  @override
  String get method => 'GET';

  @override
  String get path => '/profile';

  @override
  Map<String, dynamic>? get queryParameters => null;
}
