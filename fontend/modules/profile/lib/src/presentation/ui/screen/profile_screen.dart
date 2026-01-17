import 'package:flutter/material.dart';
import 'package:core/libs.dart';
import 'package:auth/auth.dart';
import '../../../domain/profile_repository.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = GetIt.I.get<AuthenticationRepository>();
    final profileRepo = GetIt.I.get<ProfileRepository>();

    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(profileRepo)..add(const ProfileLoadRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          title: const Text(
            'Hồ Sơ',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            String name = authRepo.currentUser?.username ?? '';
            String email = authRepo.currentUser?.email ?? '';
            String phone = '';
            String? avatarUrl;

            if (state is ProfileLoadSuccess) {
              name = state.profile.username.isNotEmpty
                  ? state.profile.username
                  : (authRepo.currentUser?.username ?? '');
              email = state.profile.email ?? email;
              phone = state.profile.phoneNumber ?? phone;
              avatarUrl = state.profile.avatarUrl;
            } else if (state is ProfileUpdateSuccess) {
              name = state.profile.username.isNotEmpty
                  ? state.profile.username
                  : (authRepo.currentUser?.username ?? '');
              email = state.profile.email ?? email;
              phone = state.profile.phoneNumber ?? phone;
              avatarUrl = state.profile.avatarUrl;
            }

            final isBusy = state is ProfileLoadInProgress || state is ProfileUpdateInProgress;

            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: _ProfileHeaderCard(
                        name: name.isNotEmpty ? name : 'Người dùng',
                        phone: phone.isNotEmpty ? phone : '+84 90 123 4567',
                        email: email.isNotEmpty ? email : 'user@example.com',
                        avatarUrl: avatarUrl,
                        onEdit: () async {
                          final controller = TextEditingController(text: avatarUrl ?? '');
                          final newUrl = await showDialog<String>(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text('Cập nhật Avatar'),
                                content: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập URL ảnh avatar',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Hủy'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
                                    child: const Text('Lưu'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (newUrl != null && newUrl.isNotEmpty && context.mounted) {
                            context.read<ProfileBloc>().add(ProfileAvatarUpdateRequested(newUrl));
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Section(
                      children: [
                        _OptionItem(
                          icon: Icons.credit_card_outlined,
                          title: 'Phương Thức Thanh Toán',
                          subtitle: 'Quản lý thẻ và ví điện tử',
                          onTap: () {},
                        ),
                        _OptionItem(
                          icon: Icons.place_outlined,
                          title: 'Địa Chỉ Đã Lưu',
                          subtitle: 'Quản lý các địa chỉ thường dùng',
                          onTap: () {},
                        ),
                        _OptionItem(
                          icon: Icons.history_outlined,
                          title: 'Lịch Sử Đơn Hàng',
                          subtitle: 'Xem tất cả đơn giao hàng',
                          onTap: () {},
                        ),
                      ],
                    ),
                    _Section(
                      children: [
                        _OptionItem(
                          icon: Icons.notifications_none,
                          title: 'Thông Báo',
                          subtitle: 'Quản lý thông báo',
                          trailing: const _Badge(count: 3),
                          onTap: () {},
                        ),
                        _OptionItem(
                          icon: Icons.help_outline,
                          title: 'Trung Tâm Hỗ Trợ',
                          subtitle: 'Nhận hỗ trợ và trợ giúp',
                          onTap: () {},
                        ),
                      ],
                    ),
                    _Section(
                      children: [
                        _OptionItem(
                          icon: Icons.logout,
                          title: 'Đăng Xuất',
                          subtitle: null,
                          onTap: () async {
                            await authRepo.logout();
                            if (context.mounted) {
                              context.go('/login');
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Phiên bản 1.0.0',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
                if (isBusy)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.05),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                if (state is ProfileUpdateSuccess && (state.message != null && state.message!.isNotEmpty))
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.message ?? 'Cập nhật thành công',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                if (state is ProfileUpdateFailure)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.message ?? 'Cập nhật thất bại',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

class _Section extends StatelessWidget {
  const _Section({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              if (i > 0) const Divider(height: 1),
              children[i],
            ]
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F4FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF5FA4E0)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(color: Colors.grey[600]),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.name,
    required this.phone,
    required this.email,
    required this.onEdit,
    this.avatarUrl,
  });

  final String name;
  final String phone;
  final String email;
  final String? avatarUrl;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final imageProvider = (avatarUrl != null && avatarUrl!.isNotEmpty)
        ? NetworkImage(avatarUrl!) as ImageProvider
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF76B4E6),
            backgroundImage: imageProvider,
            child: imageProvider == null
                ? const Icon(Icons.person, color: Colors.white, size: 28)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  phone,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Đổi avatar',
          )
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
