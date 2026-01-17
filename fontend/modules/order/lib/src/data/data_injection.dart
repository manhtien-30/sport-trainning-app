import 'package:core/libs.dart';
import '../domain/order_repository.dart';
import 'order_repository_impl.dart';

class OrderDataInjection {
  Future<void> inject() async {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<OrderRepository>()) {
      getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
    }
  }
}
