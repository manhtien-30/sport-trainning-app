import 'package:flutter/material.dart';

enum OrderStatus { all, delivering, completed, canceled }

class OrderItem {
  final String code;
  final String category; // Tài liệu, Gói Trung, Gói Lớn...
  final String fromAddress;
  final String toAddress;
  final DateTime date;
  final double distanceKm;
  final int price; // in VND
  final OrderStatus status;
  const OrderItem({
    required this.code,
    required this.category,
    required this.fromAddress,
    required this.toAddress,
    required this.date,
    required this.distanceKm,
    required this.price,
    required this.status,
  });
}

class OrderHistoryListScreen extends StatefulWidget {
  const OrderHistoryListScreen({super.key});

  @override
  State<OrderHistoryListScreen> createState() => _OrderHistoryListScreenState();
}

class _OrderHistoryListScreenState extends State<OrderHistoryListScreen> {
  OrderStatus _filter = OrderStatus.completed;

  final List<OrderItem> _items = [
    OrderItem(
      code: '#DLV-1234',
      category: 'Tài Liệu',
      fromAddress: '123 Nguyễn Huệ, Q1',
      toAddress: '456 Lê Lợi, Q3',
      date: DateTime(2025, 11, 28),
      distanceKm: 3.2,
      price: 35000,
      status: OrderStatus.completed,
    ),
    OrderItem(
      code: '#DLV-1232',
      category: 'Gói Trung',
      fromAddress: '555 Hai Bà Trưng, Q3',
      toAddress: '888 Cách Mạng Tháng 8, Q3',
      date: DateTime(2025, 11, 27),
      distanceKm: 2.5,
      price: 45000,
      status: OrderStatus.completed,
    ),
    OrderItem(
      code: '#DLV-1230',
      category: 'Gói Lớn',
      fromAddress: '999 Nguyễn Thị Minh Khai, Q1',
      toAddress: '777 Lý Thường Kiệt, Q5',
      date: DateTime(2025, 11, 25),
      distanceKm: 8.3,
      price: 85000,
      status: OrderStatus.completed,
    ),
  ];

  int get _totalOrders => _items.length;
  int get _completedCount =>
      _items.where((e) => e.status == OrderStatus.completed).length;
  int get _deliveringCount =>
      _items.where((e) => e.status == OrderStatus.delivering).length;
  int get _canceledCount =>
      _items.where((e) => e.status == OrderStatus.canceled).length;
  int get _spending => _items.fold(0, (p, e) => p + (e.status == OrderStatus.completed ? e.price : 0));

  List<OrderItem> get _filteredItems {
    if (_filter == OrderStatus.all) return _items;
    return _items.where((e) => e.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Đơn Hàng'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.5,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  Expanded(child: _SummaryCard(title: 'Tổng đơn', value: '$_totalOrders', badge: _totalOrders)),
                  const SizedBox(width: 8),
                  Expanded(child: _SummaryCard(title: 'Hoàn thành', value: '$_completedCount', badge: _completedCount)),
                  const SizedBox(width: 8),
                  Expanded(child: _SummaryCard(title: 'Chi tiêu', value: _formatVnd(_spending), badge: null)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Tất Cả', OrderStatus.all, count: _totalOrders),
                    _buildFilterChip('Đang Giao', OrderStatus.delivering, count: _deliveringCount),
                    _buildFilterChip('Hoàn Thành', OrderStatus.completed, count: _completedCount),
                    _buildFilterChip('Đã Huỷ', OrderStatus.canceled, count: _canceledCount),
                  ],
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: _filteredItems.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = _filteredItems[index];
              return _OrderCard(item: item);
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} Thg ${d.month}, ${d.year}';

  static String _formatVnd(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      buf.write(s[s.length - 1 - i]);
      if ((i + 1) % 3 == 0 && i != s.length - 1) buf.write('.');
    }
    return String.fromCharCodes(buf.toString().runes.toList().reversed) + 'đ';
  }

  Widget _buildFilterChip(String label, OrderStatus status, {int? count}) {
    final selected = _filter == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
      child: ChoiceChip(
        selected: selected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: selected ? Colors.white.withOpacity(0.2) : const Color(0xFFE9EEF6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('$count', style: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.black87)),
              )
            ]
          ],
        ),
        selectedColor: const Color(0xFF4D8DFF),
        onSelected: (_) => setState(() => _filter = status),
        backgroundColor: const Color(0xFFF1F4F9),
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999), side: BorderSide(color: selected ? const Color(0xFF4D8DFF) : const Color(0xFFE3E7ED))),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final int? badge;
  const _SummaryCard({required this.title, required this.value, this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3E7ED)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), offset: Offset(0, 2), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54))),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EEF6),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('$badge', style: const TextStyle(fontSize: 11)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderItem item;
  const _OrderCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final priceText = _OrderCard._formatVnd(item.price);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3E7ED)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), offset: Offset(0, 2), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F7EF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_shipping, size: 18, color: Color(0xFF22C55E)),
              ),
              const SizedBox(width: 10),
              Text(item.code, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              const Text('·', style: TextStyle(color: Colors.black38)),
              const SizedBox(width: 6),
              Text(item.category, style: const TextStyle(color: Colors.black54)),
              const Spacer(),
              _StatusPill(status: item.status),
            ],
          ),
          const SizedBox(height: 10),
          _AddressRow(icon: Icons.radio_button_checked, color: const Color(0xFF22C55E), text: item.fromAddress),
          const SizedBox(height: 8),
          _AddressRow(icon: Icons.radio_button_unchecked, color: const Color(0xFFEF4444), text: item.toAddress),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(_OrderCard._formatDate(item.date), style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(width: 12),
              const Text('·', style: TextStyle(color: Colors.black26)),
              const SizedBox(width: 12),
              Text('${item.distanceKm.toStringAsFixed(1)} km', style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const Spacer(),
              Text(priceText, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4D8DFF))),
            ],
          )
        ],
      ),
    );
  }

  static String _formatVnd(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      buf.write(s[s.length - 1 - i]);
      if ((i + 1) % 3 == 0 && i != s.length - 1) buf.write('.');
    }
    return String.fromCharCodes(buf.toString().runes.toList().reversed) + 'đ';
  }

  static String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final mon = d.month.toString().padLeft(2, '0');
    return '$day Thg $mon, ${d.year}';
  }
}

class _AddressRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _AddressRow({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final OrderStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;
    switch (status) {
      case OrderStatus.completed:
        bg = const Color(0xFFE7F6E9);
        fg = const Color(0xFF22C55E);
        label = 'Hoàn Thành';
        break;
      case OrderStatus.delivering:
        bg = const Color(0xFFE8F0FE);
        fg = const Color(0xFF4D8DFF);
        label = 'Đang Giao';
        break;
      case OrderStatus.canceled:
        bg = const Color(0xFFFBEAEA);
        fg = const Color(0xFFEF4444);
        label = 'Đã Huỷ';
        break;
      case OrderStatus.all:
        bg = const Color(0xFFEDEDED);
        fg = Colors.black54;
        label = 'Tất Cả';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
