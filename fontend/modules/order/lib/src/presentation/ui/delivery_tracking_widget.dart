import 'package:flutter/material.dart';

/// Delivery 7
/// Tracking/progress widget based on image/delivery/Delivery 7.png
/// Shows driver info, live status steps, ETA card and a contact button.
class DeliveryTrackingWidget extends StatelessWidget {
  final String status;
  final DateTime? eta;
  final String driverName;
  final String vehicle;
  final String plate;
  final VoidCallback? onCallDriver;
  final VoidCallback? onHelp;
  final VoidCallback? onContinue;

  const DeliveryTrackingWidget({
    super.key,
    this.status = 'Tài xế đang đến điểm lấy hàng',
    this.eta,
    this.driverName = 'Nguyễn Văn A',
    this.vehicle = 'Xe máy',
    this.plate = '59X1-123.45',
    this.onCallDriver,
    this.onHelp,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final etaText = eta == null ? '—' : _formatEta(eta!);

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
              Text('Theo Dõi Đơn Hàng', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
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
              child: const Icon(Icons.navigation_outlined, size: 48, color: Colors.black26),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: Colors.black54),
                      const SizedBox(width: 6),
                      Text('Dự kiến: $etaText'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _DriverCard(
            name: driverName,
            vehicle: vehicle,
            plate: plate,
            onCall: onCallDriver,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onHelp,
                  icon: const Icon(Icons.help_outline),
                  label: const Text('Trợ giúp'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onCallDriver,
                  icon: const Icon(Icons.call),
                  label: const Text('Gọi tài xế'),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: onContinue,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Tiếp tục'),
            ),
          ),
        ),
      ],
    );
  }

  String _formatEta(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _DriverCard extends StatelessWidget {
  final String name;
  final String vehicle;
  final String plate;
  final VoidCallback? onCall;
  const _DriverCard({required this.name, required this.vehicle, required this.plate, this.onCall});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$vehicle • $plate'),
        trailing: IconButton(icon: const Icon(Icons.call), onPressed: onCall),
      ),
    );
  }
}

class DeliveryTrackingScreen extends StatelessWidget {
  const DeliveryTrackingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryTrackingWidget(
            eta: DateTime.now().add(const Duration(minutes: 18)),
            onCallDriver: () {},
          ),
        ),
      ),
    );
  }
}
