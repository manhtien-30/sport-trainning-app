import 'package:flutter/material.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool online = true;

  Color get primaryBlue => const Color(0xFF76B4E6);
  Color get deepBlue => const Color(0xFF5FA4E0);
  Color get lightBackground => const Color(0xFFF6F9FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: const Text('Driver'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header card with avatar and online toggle
              _CardContainer(
                color: primaryBlue,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: primaryBlue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Xin chào, Tài xế',
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                              Text(
                                'Hoàn',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Text('Online', style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 6),
                              Switch(
                                value: online,
                                onChanged: (v) => setState(() => online = v),
                                activeColor: Colors.white,
                                activeTrackColor: Colors.white70,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.white38,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      online ? 'Bạn đang sẵn sàng nhận chuyến' : 'Bạn đang ngoại tuyến',
                      style: const TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Stats row
              Row(
                children: [
                  Expanded(
                    child: _CardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Thu nhập hôm nay', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                          const SizedBox(height: 6),
                          Text('350.000đ', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Chuyến đã hoàn thành', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                          const SizedBox(height: 6),
                          Text('8', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Active delivery
              _CardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _IconBadge(icon: Icons.local_shipping_outlined, bgColor: const Color(0xFFE9F4FF), iconColor: deepBlue),
                        const SizedBox(width: 8),
                        Text('Đơn hàng đang hoạt động', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _RouteTile(title: 'Nhận hàng', subtitle: '12 Nguyễn Trãi, Q1', leadingColor: Colors.green),
                    const _DashedDivider(),
                    _RouteTile(title: 'Giao hàng', subtitle: '45 Trần Hưng Đạo, Q5', leadingColor: Colors.orange),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map_outlined),
                            label: const Text('Xem bản đồ'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Bắt đầu'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Recent orders
              Text('Đơn gần đây', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _CardContainer(
                child: Column(
                  children: const [
                    _OrderItem(code: 'DH-202401', amount: '52.000đ', status: 'Hoàn thành'),
                    Divider(height: 1),
                    _OrderItem(code: 'DH-202402', amount: '74.000đ', status: 'Đã hủy', statusColor: Colors.red),
                    Divider(height: 1),
                    _OrderItem(code: 'DH-202403', amount: '128.000đ', status: 'Hoàn thành'),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _CardContainer({required this.child, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}

class _RouteTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color leadingColor;

  const _RouteTile({required this.title, required this.subtitle, required this.leadingColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6, right: 8),
          decoration: BoxDecoration(color: leadingColor, shape: BoxShape.circle),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        )
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashes = (constraints.maxWidth / 8).floor();
        return Row(
          children: List.generate(
            dashes,
            (index) => Expanded(
              child: Container(
                height: 1,
                color: index.isEven ? Colors.transparent : Colors.grey.shade300,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String code;
  final String amount;
  final String status;
  final Color statusColor;

  const _OrderItem({super.key, required this.code, required this.amount, required this.status, this.statusColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('Thu nhập: $amount', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700])),
              ],
            ),
          ),
          Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
