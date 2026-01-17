import 'package:core/src/data/network/interface/base_network_model.dart';

class GetProfileResponse extends BaseNetworkModel<GetProfileResponse> {
  final String? status;
  final String? message;
  final GetProfileResponseData? response;

  GetProfileResponse({this.status, this.message, this.response});

  @override
  GetProfileResponse fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      response: json['response'] != null
          ? GetProfileResponseData.fromJson(
              json['response'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class GetProfileResponseData {
  final String? id;
  final String? username;
  final String? email;
  final String? avatarUrl;
  final String? phoneNumber;

  GetProfileResponseData({this.id, this.username, this.email, this.avatarUrl, this.phoneNumber});

  factory GetProfileResponseData.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseData(
      id: json['id']?.toString(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }
}
