import 'package:flutter/material.dart';

/// DeliveryAddressWidget
///
/// A reusable UI widget built based on the mockup "Delivery 2.png" under image/delivery.
/// It shows:
/// - A search field
/// - A tile for "Use Current Location"
/// - A list of recent addresses
/// - A list of suggested places
/// - A bottom button: "Chọn Trên Bản Đồ"
///
/// All data is provided by constructor; if omitted, demo data is shown.
class DeliveryAddressWidget extends StatelessWidget {
  final List<AddressItem> recentAddresses;
  final List<AddressItem> suggestedPlaces;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onUseCurrentLocation;
  final ValueChanged<AddressItem>? onSelectAddress;
  final VoidCallback? onChooseOnMap;
  final TextEditingController? searchController;

  const DeliveryAddressWidget({
    super.key,
    this.recentAddresses = const [
      AddressItem(title: 'Nhà Riêng', address: '123 Nguyễn Huệ, Q1'),
      AddressItem(title: 'Văn Phòng', address: '456 Lê Lợi, Q1'),
    ],
    this.suggestedPlaces = const [
      AddressItem(title: 'Vincom Center', address: '72 Lê Thánh Tôn, Q1'),
      AddressItem(title: 'Bến Xe Miền Đông', address: '292 Đinh Bộ Lĩnh, Bình Thạnh'),
    ],
    this.onSearchChanged,
    this.onUseCurrentLocation,
    this.onSelectAddress,
    this.onChooseOnMap,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = searchController ?? TextEditingController();

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
                onPressed: () => Navigator.maybePop(context),
              ),
              const SizedBox(width: 4),
              Text('Địa Chỉ Giao Hàng', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Search field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm địa điểm',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
        const SizedBox(height: 12),
        // Use current location
        _SectionCard(
          child: ListTile(
            leading: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFEFF5FF),
              child: Icon(Icons.near_me, color: Color(0xFF2979FF)),
            ),
            title: const Text('Dùng Vị Trí Hiện Tại'),
            subtitle: const Text('Bật dịch vụ định vị'),
            onTap: onUseCurrentLocation,
            dense: true,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
          ),
        ),
        const SizedBox(height: 8),
        // Recent section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.black45),
              const SizedBox(width: 6),
              Text('Gần Đây', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...recentAddresses.map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: _AddressTile(item: e, onTap: () => onSelectAddress?.call(e)),
            )),
        const SizedBox(height: 12),
        // Suggested places
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Địa Điểm Gợi Ý', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 8),
        ...suggestedPlaces.map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: _AddressTile(item: e, onTap: () => onSelectAddress?.call(e)),
            )),
        const SizedBox(height: 16),
        // Spacer-like
        const SizedBox(height: 8),
        // Bottom button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: onChooseOnMap,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Chọn Trên Bản Đồ'),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddressTile extends StatelessWidget {
  final AddressItem item;
  final VoidCallback? onTap;
  const _AddressTile({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: ListTile(
        leading: const CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xFFEFF5FF),
          child: Icon(Icons.place_outlined, color: Color(0xFF2979FF)),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(item.address),
        onTap: onTap,
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3E7ED)),
      ),
      child: child,
    );
  }
}

class AddressItem {
  final String title;
  final String address;
  const AddressItem({required this.title, required this.address});
}

/// Optional convenience screen to showcase the widget quickly.
class DeliveryAddressScreen extends StatelessWidget {
  final VoidCallback? onChooseOnMap;
  const DeliveryAddressScreen({super.key, this.onChooseOnMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryAddressWidget(onChooseOnMap: onChooseOnMap),
        ),
      ),
    );
  }
}
