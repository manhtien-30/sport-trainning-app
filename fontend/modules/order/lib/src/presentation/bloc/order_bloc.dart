import 'package:core/libs.dart';
import '../../../order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _repository;

  OrderBloc({required OrderRepository repository})
      : _repository = repository,
        super(const OrderState()) {
    on<CreateDeliveryOrderEvent>(_onCreateDeliveryOrder);
  }

  factory OrderBloc.di() => OrderBloc(repository: GetIt.instance.get<OrderRepository>());

  Future<void> _onCreateDeliveryOrder(
    CreateDeliveryOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading, errorMessage: null));
    try {
      final order = await _repository.createDeliveryOrder(event.params);
      emit(state.copyWith(status: OrderStatus.success, lastOrder: order));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.toString()));
    }
  }
}
