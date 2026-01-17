import 'package:flutter/material.dart';
import 'package:core/libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Color get primaryBlue => const Color(0xFF76B4E6);
  Color get deepBlue => const Color(0xFF5FA4E0);
  Color get lightBackground => const Color(0xFFF6F9FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào mừng trở lại,',
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hoàn',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_outline, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Quick action card: Gửi Hàng Ngay
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).go('/order/create-delivery'),
                  child: _CardContainer(
                    child: Row(
                      children: [
                        _IconBadge(
                          icon: Icons.local_shipping_outlined,
                          bgColor: const Color(0xFFE9F4FF),
                          iconColor: deepBlue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gửi Hàng Ngay',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 2),
                              Text('Đặt đơn giao hàng mới',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Promo card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _CardContainer(
                  color: const Color(0xFFE9F2FF),
                  child: Row(
                    children: [
                      _IconBadge(
                        icon: Icons.local_offer_outlined,
                        bgColor: Colors.white,
                        iconColor: deepBlue,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Giảm 20%',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2E476E),
                                )),
                            const SizedBox(height: 2),
                            Text('Dùng mã FIRST20 cho đơn đầu',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF5B6E8E),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Section: Địa Chỉ Gần Đây
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Địa Chỉ Gần Đây',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2E476E),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: const [
                    _AddressItem(
                      title: 'Nhà Riêng',
                      address: '123 Nguyễn Huệ, Quận 1, TP.HCM',
                    ),
                    SizedBox(height: 10),
                    _AddressItem(
                      title: 'Văn Phòng',
                      address: '456 Lê Lợi, Tầng 12, Quận 1, TP.HCM',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Section: Đơn Đang Giao + Xem Tất Cả
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đơn Đang Giao',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E476E),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Xem Tất Cả'),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _CardContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _IconBadge(
                            icon: Icons.local_shipping_outlined,
                            bgColor: const Color(0xFFE9F4FF),
                            iconColor: deepBlue,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('#DLV-1234',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(height: 2),
                                Text('Tài liệu',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[700],
                                    )),
                              ],
                            ),
                          ),
                          _StatusPill(label: 'Đang Giao', color: deepBlue),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Text('Giao trong 15 phút',
                              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  const _CardContainer({required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  const _IconBadge({required this.icon, required this.bgColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

class _AddressItem extends StatelessWidget {
  final String title;
  final String address;
  const _AddressItem({required this.title, required this.address});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBadge(
            icon: Icons.location_on_outlined,
            bgColor: const Color(0xFFE9F4FF),
            iconColor: const Color(0xFF5FA4E0),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(address, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}