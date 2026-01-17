import 'package:core/src/data/network/interface/base_network_model.dart';

class SignInResponse extends BaseNetworkModel<SignInResponse> {
  final String? status;
  final String? message;
  final SignInResponseData? response;

  SignInResponse({this.status, this.message, this.response});

  @override
  SignInResponse fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      response: json['response'] != null
          ? SignInResponseData.fromJson(json['response'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SignInResponseData {
  final String? token;
  final String? type;
  final String? id;
  final String? username;
  final String? email;
  final String? lastLogin;
  final List<String>? roles;

  SignInResponseData({
    this.token,
    this.type,
    this.id,
    this.username,
    this.email,
    this.lastLogin,
    this.roles,
  });

  factory SignInResponseData.fromJson(Map<String, dynamic> json) {
    final rolesJson = json['roles'];
    return SignInResponseData(
      token: json['token'] as String?,
      type: json['type'] as String?,
      id: json['id']?.toString(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      lastLogin: json['lastLogin'] as String?,
      roles: rolesJson is List
          ? rolesJson.map((e) => e.toString()).toList().cast<String>()
          : null,
    );
  }
}
