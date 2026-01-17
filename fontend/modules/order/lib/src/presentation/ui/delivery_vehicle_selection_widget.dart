import 'package:flutter/material.dart';

/// DeliveryVehicleSelectionWidget
///
/// Built based on mockup: image/delivery/Delivery 3.png
/// It shows a header, a section title, three vehicle options with prices,
/// and a bottom Continue button.
///
/// The widget is reusable: pass custom options, selection and callbacks.
class DeliveryVehicleSelectionWidget extends StatefulWidget {
  final List<VehicleOption> options;
  final int? initialSelectedIndex;
  final ValueChanged<VehicleOption>? onChanged;
  final VoidCallback? onBack;
  final VoidCallback? onContinue;
  final String title;
  final String sectionTitle;
  final String sectionSubtitle;
  final String continueLabel;

  const DeliveryVehicleSelectionWidget({
    super.key,
    this.options = const [
      VehicleOption(
        title: 'Xe Máy',
        subtitle: 'Hàng nhỏ, giao nhanh',
        priceText: '15.000đ',
        icon: Icons.two_wheeler,
        color: Color(0xFFEFF5FF),
        iconColor: Color(0xFF2979FF),
      ),
      VehicleOption(
        title: 'Xe Ô Tô',
        subtitle: 'Hàng trung bình',
        priceText: '35.000đ',
        icon: Icons.directions_car,
        color: Color(0xFFEFF5FF),
        iconColor: Color(0xFF2979FF),
      ),
      VehicleOption(
        title: 'Xe Tải',
        subtitle: 'Hàng lớn, rộng rãi',
        priceText: '70.000đ',
        icon: Icons.local_shipping,
        color: Color(0xFFEFF5FF),
        iconColor: Color(0xFF2979FF),
      ),
    ],
    this.initialSelectedIndex,
    this.onChanged,
    this.onBack,
    this.onContinue,
    this.title = 'Chọn Xe',
    this.sectionTitle = 'Chọn loại phương tiện',
    this.sectionSubtitle = 'Dựa trên kích thước hàng hóa',
    this.continueLabel = 'Tiếp Tục',
  });

  @override
  State<DeliveryVehicleSelectionWidget> createState() => _DeliveryVehicleSelectionWidgetState();
}

class _DeliveryVehicleSelectionWidgetState extends State<DeliveryVehicleSelectionWidget> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _select(int index) {
    setState(() => _selectedIndex = index);
    widget.onChanged?.call(widget.options[index]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: widget.onBack ?? () => Navigator.maybePop(context),
              ),
              const SizedBox(width: 4),
              Text(widget.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.sectionTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(widget.sectionSubtitle, style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Options
        ...List.generate(widget.options.length, (i) {
          final opt = widget.options[i];
          final selected = _selectedIndex == i;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: _VehicleTile(
              option: opt,
              selected: selected,
              onTap: () => _select(i),
            ),
          );
        }),
        const SpacerWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: widget.onContinue,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF90CAF9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(widget.continueLabel),
            ),
          ),
        ),
      ],
    );
  }
}

class _VehicleTile extends StatelessWidget {
  final VehicleOption option;
  final bool selected;
  final VoidCallback? onTap;

  const _VehicleTile({
    required this.option,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? const Color(0xFF90CAF9) : const Color(0xFFE3E7ED);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: selected ? 2 : 1),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: option.color,
            child: Icon(option.icon, color: option.iconColor),
          ),
          title: Text(option.title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(option.subtitle),
          trailing: Text(option.priceText, style: const TextStyle(fontWeight: FontWeight.w600)),
          dense: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
        ),
      ),
    );
  }
}

class VehicleOption {
  final String title;
  final String subtitle;
  final String priceText; // Keep as text to allow currency suffixes
  final IconData icon;
  final Color color;
  final Color iconColor;

  const VehicleOption({
    required this.title,
    required this.subtitle,
    required this.priceText,
    required this.icon,
    this.color = const Color(0xFFEFF5FF),
    this.iconColor = const Color(0xFF2979FF),
  });
}

/// Spacer helper to mimic large free space like in the mockup
class SpacerWidget extends StatelessWidget {
  const SpacerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 24);
  }
}

/// Optional screen to preview the widget quickly (not routed by default)
class DeliveryVehicleSelectionScreen extends StatelessWidget {
  const DeliveryVehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? selected;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                Expanded(
                  child: DeliveryVehicleSelectionWidget(
                    initialSelectedIndex: selected,
                    onChanged: (_) => setState(() {}),
                    onContinue: () {},
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
