import 'package:flutter/material.dart';

/// Delivery 6
/// Overview/landing widget showcasing delivery service benefits based on Delivery 6.png
/// Includes header illustration, feature bullets and a primary button.
class DeliveryOverviewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> features;
  final VoidCallback? onStart;

  const DeliveryOverviewWidget({
    super.key,
    this.title = 'Dịch vụ giao hàng',
    this.subtitle = 'Tạo đơn giao nhận nhanh chóng, theo dõi trạng thái dễ dàng.',
    this.features = const [
      'Tài xế gần bạn',
      'Giá minh bạch',
      'Theo dõi thời gian thực',
    ],
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 180,
              width: double.infinity,
              color: const Color(0xFFEFEFEF),
              alignment: Alignment.center,
              child: const Icon(Icons.local_shipping_outlined, size: 56, color: Colors.black26),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54)),
        ),
        const SizedBox(height: 12),
        ...features.map((f) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f)),
                ],
              ),
            )),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.local_shipping_outlined),
              label: const Text('Bắt đầu tạo đơn'),
            ),
          ),
        ),
      ],
    );
  }
}

class DeliveryOverviewScreen extends StatelessWidget {
  const DeliveryOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryOverviewWidget(
            onStart: () {},
          ),
        ),
      ),
    );
  }
}
