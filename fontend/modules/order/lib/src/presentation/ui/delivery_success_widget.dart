import 'package:flutter/material.dart';

/// Delivery 8
/// Success/Completion widget matching image/delivery/Delivery 8.png
/// Can be reused by final screens to show success state and next actions.
class DeliverySuccessWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onCreateNew;
  final VoidCallback? onGoHome;

  const DeliverySuccessWidget({
    super.key,
    this.title = 'Tạo đơn thành công',
    this.message = 'Đơn hàng của bạn đã được tạo. Bạn có thể theo dõi trong phần Theo dõi.',
    this.onCreateNew,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 180,
            width: double.infinity,
            color: const Color(0xFFEFEFEF),
            alignment: Alignment.center,
            child: const Icon(Icons.celebration_outlined, size: 56, color: Colors.black26),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 24),
            SizedBox(width: 8),
            Text('Tạo đơn thành công', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.green)),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Bạn có thể xem chi tiết đơn hàng và theo dõi tiến trình giao hàng trong mục theo dõi.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onGoHome,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Về trang chủ'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: onCreateNew,
                icon: const Icon(Icons.add),
                label: const Text('Tạo đơn mới'),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DeliverySuccessScreen extends StatelessWidget {
  const DeliverySuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DeliverySuccessWidget(
            onCreateNew: () {},
            onGoHome: () {},
          ),
        ),
      ),
    );
  }
}
