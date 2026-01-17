part of 'payment_module.dart';

class _PaymentModuleImpl extends PaymentModule {
  _PaymentModuleImpl();

  @override
  Future<void> inject() async {
    await PaymentDataInjection().inject();
  }

  @override
  List<LocalizationsDelegate<dynamic>> get locallizationsDelegates => const [];
}
