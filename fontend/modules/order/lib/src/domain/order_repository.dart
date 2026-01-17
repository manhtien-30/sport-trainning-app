import 'package:core/libs.dart';

class DeliveryOrder {
  final String id;
  final String status; // e.g., created, preparing_pickup, delivering, delivered
  final String pickupAddress;
  final String dropoffAddress;
  final int? fee; // in smallest currency unit, e.g. VND
  final DateTime createdAt;
  final DateTime? scheduledAt;

  const DeliveryOrder({
    required this.id,
    required this.status,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.createdAt,
    this.fee,
    this.scheduledAt,
  });
}

class CreateDeliveryOrderParams {
  final String pickupAddress;
  final String dropoffAddress;
  final List<Map<String, dynamic>>? items; // minimal typing, flexible per backend
  final String? notes;
  final DateTime? scheduledAt;

  const CreateDeliveryOrderParams({
    required this.pickupAddress,
    required this.dropoffAddress,
    this.items,
    this.notes,
    this.scheduledAt,
  });

  Map<String, dynamic> toJson() => {
        'pickupAddress': pickupAddress,
        'dropoffAddress': dropoffAddress,
        if (items != null) 'items': items,
        if (notes != null) 'notes': notes,
        if (scheduledAt != null) 'scheduledAt': scheduledAt!.toIso8601String(),
      };
}

abstract class OrderRepository {
  Future<DeliveryOrder> createDeliveryOrder(CreateDeliveryOrderParams params);
}
