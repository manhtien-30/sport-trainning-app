abstract class PaymentRepository {
  Future<PaymentResult> pay(PaymentRequest request);
}

class PaymentRequest {
  final String orderId;
  final int amount;
  final String currency;
  final String method; // e.g., "cod", "card", "wallet"

  const PaymentRequest({
    required this.orderId,
    required this.amount,
    this.currency = 'VND',
    this.method = 'cod',
  });
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? message;

  const PaymentResult({
    required this.success,
    this.transactionId,
    this.message,
  });
}
