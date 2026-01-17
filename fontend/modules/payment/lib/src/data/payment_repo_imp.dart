import 'dart:async';
import '../domain/payment_repository.dart';

class PaymentRepositoryImp implements PaymentRepository {
  PaymentRepositoryImp();

  @override
  Future<PaymentResult> pay(PaymentRequest request) async {
    // Mock a network delay and return success
    await Future.delayed(const Duration(seconds: 1));
    // Generate a fake transaction id
    final txId = 'TX-${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(success: true, transactionId: txId, message: 'Thanh toán thành công');
  }
}
