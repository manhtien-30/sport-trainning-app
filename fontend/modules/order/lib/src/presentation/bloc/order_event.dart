part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class CreateDeliveryOrderEvent extends OrderEvent {
  final CreateDeliveryOrderParams params;

  const CreateDeliveryOrderEvent(this.params);

  @override
  List<Object?> get props => [params];
}
