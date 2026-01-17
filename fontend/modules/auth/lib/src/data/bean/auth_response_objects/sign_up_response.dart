import 'package:core/src/data/network/interface/base_network_model.dart';

class SignUpResponse extends BaseNetworkModel<SignUpResponse> {
  final String? message;
  final String? userId;

  SignUpResponse({this.message, this.userId});

  @override
  SignUpResponse fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message'] as String?,
      userId: (json['userId'] ?? json['id'])?.toString(),
    );
  }
}
