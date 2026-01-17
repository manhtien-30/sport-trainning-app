import 'package:get_it/get_it.dart';

import '../domain/payment_repository.dart';
import 'payment_repo_imp.dart';

class PaymentDataInjection {
  final _getIt = GetIt.instance;

  Future<void> inject() async {
    if (!_getIt.isRegistered<PaymentRepository>()) {
      _getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImp());
    }
  }
}
