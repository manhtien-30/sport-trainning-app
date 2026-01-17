import 'package:core/core.dart';
import 'package:auth/auth.dart';

class UpdateProfileRequest extends BaseClientGenerator {
  String id;
  String username;
  String? email;
  String? avatarUrl;

  UpdateProfileRequest({required this.id, required this.username, this.email, this.avatarUrl});

  @override
  String get baseURL => GetIt.instance.get<CoreEnvironment>().baseUrl;

  @override
  dynamic get body => {
        'id': id,
        'username': username,
        if (email != null) 'email': email,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };

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
  String get method => "POST";

  @override
  String get path => "/profile";

  @override
  Map<String, dynamic>? get queryParameters => null;
}
