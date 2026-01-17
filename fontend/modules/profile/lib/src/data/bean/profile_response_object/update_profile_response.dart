import 'package:core/src/data/network/interface/base_network_model.dart';

class UpdateProfileResponse extends BaseNetworkModel<UpdateProfileResponse> {
  final String? status;
  final String? message;
  final UpdateProfileResponseData? response;

  UpdateProfileResponse({this.status, this.message, this.response});

  @override
  UpdateProfileResponse fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      response: json['response'] != null
          ? UpdateProfileResponseData.fromJson(
              json['response'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class UpdateProfileResponseData {
  final String? id;
  final String? username;
  final String? email;
  final String? avatarUrl;

  UpdateProfileResponseData({this.id, this.username, this.email, this.avatarUrl});

  factory UpdateProfileResponseData.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseData(
      id: json['id']?.toString(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}
