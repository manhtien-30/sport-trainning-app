import 'package:flutter/material.dart';

/// Delivery 5
/// Price estimation / confirmation styled widget based on image/delivery/Delivery 5.png
/// Shows pickup/dropoff summary, distance, estimated fee, promo code input and continue button.
class DeliveryPriceEstimateWidget extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final double? distanceKm;
  final int? estimatedFee;
  final ValueChanged<String>? onApplyPromo;
  final VoidCallback? onContinue;

  const DeliveryPriceEstimateWidget({
    super.key,
    this.pickup = '123 Nguyễn Trãi, Q1',
    this.dropoff = '456 Lý Thường Kiệt, Q10',
    this.distanceKm,
    this.estimatedFee,
    this.onApplyPromo,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feeText = estimatedFee == null ? '—' : '${estimatedFee} đ';
    final distanceText = distanceKm == null ? '—' : '${distanceKm!.toStringAsFixed(1)} km';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: () => Navigator.maybePop(context),
              ),
              const SizedBox(width: 4),
              Text('Ước Tính Chi Phí', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 140,
              width: double.infinity,
              color: const Color(0xFFEFEFEF),
              alignment: Alignment.center,
              child: const Icon(Icons.receipt_long_outlined, size: 48, color: Colors.black26),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _row('Lấy hàng', pickup),
                  _row('Giao đến', dropoff),
                  const Divider(height: 24),
                  _row('Quãng đường', distanceText),
                  _row('Ước tính phí', feeText),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onSubmitted: onApplyPromo,
            decoration: InputDecoration(
              hintText: 'Nhập mã khuyến mãi',
              prefixIcon: const Icon(Icons.local_offer_outlined),
              suffixIcon: IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () {},
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE3E7ED)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE3E7ED)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: onContinue,
              child: const Text('Tiếp Tục'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(color: Colors.black54))),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class DeliveryPriceEstimateScreen extends StatelessWidget {
  const DeliveryPriceEstimateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryPriceEstimateWidget(
            distanceKm: 5.2,
            estimatedFee: 45000,
            onContinue: () {},
          ),
        ),
      ),
    );
  }
}
