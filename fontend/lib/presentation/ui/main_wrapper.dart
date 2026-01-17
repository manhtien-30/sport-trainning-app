import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:auth/src/domain/authentication_repository.dart';

import '../route.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  const MainWrapper({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouteNames.profile)) return 2;
    if (location.startsWith(AppRouteNames.orderListHistory)) return 1;
    // Default to home or driverHome both map to first tab
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Navigate to the correct home by role
        final repo = GetIt.I.get<AuthenticationRepository>();
        final roles = repo.currentUser?.roles ?? const [];
        final isDriver = roles.any((r) => r.toUpperCase().contains('ROLE_DRIVER'));
        context.go(isDriver ? AppRouteNames.driverHome : AppRouteNames.home);
        break;
      case 1:
        context.go(AppRouteNames.orderListHistory);
        break;
      case 2:
        context.go(AppRouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int inx) => _onItemTapped(inx, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Đơn"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}