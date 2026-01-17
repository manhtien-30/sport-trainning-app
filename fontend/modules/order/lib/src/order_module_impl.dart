part of 'order_module.dart';

class _OrderModuleImpl extends OrderModule {
  _OrderModuleImpl();

  @override
  Future<void> inject() async {
    // Register order-related dependencies here.
    // Mirror of core's DataInjection flow.
    await OrderDataInjection().inject();
  }

  @override
  List<LocalizationsDelegate<dynamic>> get locallizationsDelegates => const [];

  @override
  Future<DeliveryOrder> createDeliveryOrder(CreateDeliveryOrderParams params) async {
    final repo = GetIt.instance.get<OrderRepository>();
    return repo.createDeliveryOrder(params);
  }
}
