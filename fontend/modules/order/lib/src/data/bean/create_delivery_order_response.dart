import 'package:core/src/data/network/interface/base_network_model.dart';

class CreateDeliveryOrderResponse extends BaseNetworkModel<CreateDeliveryOrderResponse> {
  final String? status;
  final String? message;
  final CreateDeliveryOrderResponseData? response;

  CreateDeliveryOrderResponse({this.status, this.message, this.response});

  @override
  CreateDeliveryOrderResponse fromJson(Map<String, dynamic> json) {
    return CreateDeliveryOrderResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      response: json['response'] != null
          ? CreateDeliveryOrderResponseData.fromJson(json['response'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateDeliveryOrderResponseData {
  final String? id;
  final String? status;
  final String? pickupAddress;
  final String? dropoffAddress;
  final int? fee;
  final String? createdAt;
  final String? scheduledAt;

  CreateDeliveryOrderResponseData({
    this.id,
    this.status,
    this.pickupAddress,
    this.dropoffAddress,
    this.fee,
    this.createdAt,
    this.scheduledAt,
  });

  factory CreateDeliveryOrderResponseData.fromJson(Map<String, dynamic> json) {
    return CreateDeliveryOrderResponseData(
      id: json['id']?.toString(),
      status: json['status'] as String?,
      pickupAddress: json['pickupAddress'] as String?,
      dropoffAddress: json['dropoffAddress'] as String?,
      fee: json['fee'] is int ? json['fee'] as int : int.tryParse(json['fee']?.toString() ?? ''),
      createdAt: json['createdAt'] as String?,
      scheduledAt: json['scheduledAt'] as String?,
    );
  }
}
