import 'package:flutter/material.dart';
import 'package:core/libs.dart';
import 'package:order/order.dart';

class DeliveryOrderFinalScreen extends StatelessWidget {
  final DeliveryOrder? orderFromExtra;
  const DeliveryOrderFinalScreen({super.key, this.orderFromExtra});

  @override
  Widget build(BuildContext context) {
    final order = orderFromExtra;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Hoàn tất đơn hàng'),
        centerTitle: true,
      ),
      body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF5F7FB), Color(0xFFFFFFFF)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Illustration + success text
                      Center(
                        child: Column(
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Summary card
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _row(context, 'Mã đơn', order?.id ?? '—'),
                              _row(context, 'Trạng thái', order?.status ?? '—'),
                              const Divider(height: 24),
                              _row(context, 'Lấy hàng', order?.pickupAddress ?? '—'),
                              _row(context, 'Giao đến', order?.dropoffAddress ?? '—'),
                              const Divider(height: 24),
                              _row(context, 'Thời gian tạo', order?.createdAt?.toLocal().toString() ?? '—'),
                              _row(context, 'Thời gian hẹn', order?.scheduledAt?.toLocal().toString() ?? '—'),
                              _row(context, 'Phí', order?.fee != null ? '${order?.fee} đ' : '—'),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => GoRouter.of(context).go('/home'),
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
                              onPressed: () => GoRouter.of(context).go('/order/create-delivery'),
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
                  ),
                ),
              ),
            ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    final styleLabel = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54);
    final styleValue = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: styleLabel)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: styleValue)),
        ],
      ),
    );
  }
}
