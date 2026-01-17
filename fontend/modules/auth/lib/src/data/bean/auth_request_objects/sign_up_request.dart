import 'package:core/core.dart';

class SignUpRequestBody {
  String username;
  String password;
  String? firstname;
  String? lastname;
  String email;

  SignUpRequestBody({required this.username, required this.password, required this.email});
}

/// Client to perform user registration (signup) requests
class SignUpRequestClient extends BaseClientGenerator {
  final SignUpRequestBody signUpRequestBody;

  SignUpRequestClient({required this.signUpRequestBody});

  @override
  String get baseURL => GetIt.instance.get<CoreEnvironment>().baseUrl;

  @override
  dynamic get body {
    final map = <String, dynamic>{
      'username': signUpRequestBody.username,
      'password': signUpRequestBody.password,
    };
    if (signUpRequestBody.email != null && signUpRequestBody.email!.isNotEmpty) {
      map['email'] = signUpRequestBody.email;
    }
    return map;
  }

  @override
  Map<String, dynamic> get header => {'Content-Type': 'application/json'};

  @override
  String get method => 'POST';

  @override
  String get path => '/auth/signup';

  @override
  Map<String, dynamic>? get queryParameters => null;
}
