import 'package:core/core.dart';
import '../domain/order_repository.dart';
import 'bean/create_delivery_order_request.dart';
import 'bean/create_delivery_order_response.dart';

class OrderRepositoryImpl implements OrderRepository {
  DeliveryOrder? _lastCreatedCache;

  @override
  Future<DeliveryOrder> createDeliveryOrder(CreateDeliveryOrderParams params) async {
    final result = await NetworkExecutor.executed<CreateDeliveryOrderResponse, CreateDeliveryOrderResponse>(
      route: CreateDeliveryOrderRequest(params),
      responseType: CreateDeliveryOrderResponse(),
    );

    return await result.when(
      success: (res) async {
        final data = res.response;
        if (data == null) {
          // Fallback to minimal data from params
          final order = DeliveryOrder(
            id: _lastCreatedCache?.id ?? 'temp',
            status: 'created',
            pickupAddress: params.pickupAddress,
            dropoffAddress: params.dropoffAddress,
            createdAt: DateTime.now(),
            fee: null,
            scheduledAt: params.scheduledAt,
          );
          _lastCreatedCache = order;
          return order;
        }
        final order = DeliveryOrder(
          id: data.id ?? 'unknown',
          status: data.status ?? 'created',
          pickupAddress: data.pickupAddress ?? params.pickupAddress,
          dropoffAddress: data.dropoffAddress ?? params.dropoffAddress,
          fee: data.fee,
          createdAt: DateTime.tryParse(data.createdAt ?? '') ?? DateTime.now(),
          scheduledAt: data.scheduledAt != null ? DateTime.tryParse(data.scheduledAt!) : params.scheduledAt,
        );
        _lastCreatedCache = order;
        return order;
      },
      failure: (error) async {
        throw Exception(error.localizedErrorMessage ?? 'Create delivery order failed');
      },
    );
  }
}
