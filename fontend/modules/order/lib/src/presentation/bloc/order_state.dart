part of 'order_bloc.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderStatus status;
  final DeliveryOrder? lastOrder;
  final String? errorMessage;

  const OrderState({this.status = OrderStatus.initial, this.lastOrder, this.errorMessage});

  OrderState copyWith({OrderStatus? status, DeliveryOrder? lastOrder, String? errorMessage, bool clearError = false}) {
    return OrderState(
      status: status ?? this.status,
      lastOrder: lastOrder ?? this.lastOrder,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, lastOrder, errorMessage];
}
