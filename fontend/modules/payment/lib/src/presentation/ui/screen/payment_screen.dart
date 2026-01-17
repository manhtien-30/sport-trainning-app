import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/payment_repository.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _loading = false;
  String _message = '';

  Future<void> _onPay() async {
    setState(() {
      _loading = true;
      _message = '';
    });
    final repo = GetIt.I.get<PaymentRepository>();
    final result = await repo.pay(const PaymentRequest(orderId: 'ORDER-001', amount: 100000));
    setState(() {
      _loading = false;
      _message = result.success
          ? 'Thanh toán thành công\nMã giao dịch: ${result.transactionId}'
          : (result.message ?? 'Thanh toán thất bại');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Demo thanh toán', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _onPay,
              child: _loading
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Thanh toán 100.000đ'),
            ),
            const SizedBox(height: 16),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
