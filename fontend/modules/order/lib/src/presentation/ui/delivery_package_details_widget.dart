import 'package:flutter/material.dart';

/// Delivery 4
/// A simple package details widget following the visual from image/delivery/Delivery 4.png
/// Includes: package size selector, notes, COD toggle and a continue button.
class DeliveryPackageDetailsWidget extends StatefulWidget {
  final List<String> sizes;
  final ValueChanged<String>? onSizeChanged;
  final ValueChanged<String>? onNotesChanged;
  final ValueChanged<bool>? onCodChanged;
  final VoidCallback? onContinue;

  const DeliveryPackageDetailsWidget({
    super.key,
    this.sizes = const ['Nhỏ', 'Vừa', 'Lớn'],
    this.onSizeChanged,
    this.onNotesChanged,
    this.onCodChanged,
    this.onContinue,
  });

  @override
  State<DeliveryPackageDetailsWidget> createState() => _DeliveryPackageDetailsWidgetState();
}

class _DeliveryPackageDetailsWidgetState extends State<DeliveryPackageDetailsWidget> {
  String _selected = 'Nhỏ';
  bool _cod = false;
  final _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Text('Chi Tiết Gói Hàng', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
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
              child: const Icon(Icons.inventory_2_outlined, size: 48, color: Colors.black26),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Kích thước', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: widget.sizes.map((s) {
              final selected = _selected == s;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(s),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => _selected = s);
                    widget.onSizeChanged?.call(s);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SwitchListTile(
            value: _cod,
            title: const Text('Thu hộ (COD)'),
            subtitle: const Text('Tài xế thu tiền người nhận'),
            onChanged: (v) {
              setState(() => _cod = v);
              widget.onCodChanged?.call(v);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _notes,
            maxLines: 3,
            onChanged: widget.onNotesChanged,
            decoration: InputDecoration(
              labelText: 'Ghi chú cho tài xế',
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
              onPressed: widget.onContinue,
              child: const Text('Tiếp Tục'),
            ),
          ),
        ),
      ],
    );
  }
}

/// Optional preview screen
class DeliveryPackageDetailsScreen extends StatelessWidget {
  const DeliveryPackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryPackageDetailsWidget(
            onContinue: () {},
          ),
        ),
      ),
    );
  }
}
