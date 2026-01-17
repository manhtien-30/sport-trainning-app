import 'package:core/core.dart';

class SignInRequestBody {
  String username;
  String password;

  SignInRequestBody({required this.username, required this.password});
}

/// Client to perform authentication (login) requests
class SignInRequestClient extends BaseClientGenerator {
  final SignInRequestBody signInRequestBody;
  const SignInRequestClient(this.signInRequestBody) : super();

  @override
  String get baseURL => GetIt.instance.get<CoreEnvironment>().baseUrl;
  @override
  dynamic get body => {
    'username': signInRequestBody.username,
    'password': signInRequestBody.password,
  };

  @override
  Map<String, dynamic> get header => {'Content-Type': 'application/json'};

  @override
  String get method => 'POST';

  @override
  String get path => '/auth/sign-in';

  @override
  Map<String, dynamic>? get queryParameters => null;
}
