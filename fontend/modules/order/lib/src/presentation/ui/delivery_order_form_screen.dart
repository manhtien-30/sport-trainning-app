import 'package:flutter/material.dart';
import 'package:core/libs.dart';

/// Delivery 1 - Create Delivery
///
/// Re-created entry screen for creating a delivery order based on image/delivery/Delivery.png.
/// Includes hero illustration, pickup/dropoff inputs, notes, schedule toggle, and primary action.
class DeliveryOrderFormScreen extends StatefulWidget {
  const DeliveryOrderFormScreen({super.key});

  @override
  State<DeliveryOrderFormScreen> createState() => _DeliveryOrderFormScreenState();
}

class _DeliveryOrderFormScreenState extends State<DeliveryOrderFormScreen> {
  final _pickupCtrl = TextEditingController();
  final _dropoffCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _isSchedule = false;
  DateTime? _scheduledAt;

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _dropoffCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(minutes: 30))),
    );
    if (time == null) return;
    setState(() {
      _scheduledAt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _startFlow() {
    // For now, just navigate to the first step of the connected flow.
    GoRouter.of(context).push('/order/delivery/address');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Tạo đơn giao hàng'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('Thông tin giao hàng', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _LabeledField(
                  label: 'Điểm lấy hàng',
                  hint: 'Nhập địa chỉ lấy hàng',
                  controller: _pickupCtrl,
                  icon: Icons.store_mall_directory_outlined,
                ),
                const SizedBox(height: 12),
                _LabeledField(
                  label: 'Điểm giao đến',
                  hint: 'Nhập địa chỉ giao đến',
                  controller: _dropoffCtrl,
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 12),
                _LabeledField(
                  label: 'Ghi chú cho tài xế (tuỳ chọn)',
                  hint: 'Ví dụ: gọi trước khi đến',
                  controller: _noteCtrl,
                  maxLines: 3,
                  icon: Icons.notes_outlined,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE3E7ED)),
                  ),
                  child: SwitchListTile(
                    value: _isSchedule,
                    title: const Text('Hẹn giờ lấy hàng'),
                    subtitle: Text(_scheduledAt == null
                        ? 'Lấy hàng ngay'
                        : 'Thời gian: ${_formatDateTime(_scheduledAt!)}'),
                    onChanged: (v) async {
                      setState(() => _isSchedule = v);
                      if (v) {
                        await _pickSchedule();
                      } else {
                        setState(() => _scheduledAt = null);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _startFlow,
                    icon: const Icon(Icons.local_shipping_outlined),
                    label: const Text('Tiếp tục'),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year.toString();
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d/$m/$y $h:$min';
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final IconData? icon;

  const _LabeledField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 6),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon == null ? null : Icon(icon),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
      ],
    );
  }
}
