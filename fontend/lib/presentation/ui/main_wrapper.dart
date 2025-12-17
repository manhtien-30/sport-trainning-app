import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontend/presentation/route.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatelessWidget{
  final Widget child;
  const MainWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int inx) => _onItemTapped(inx, context),
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile")
          ]),
    );
  }
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouteNames.home)) return 0;
    if (location.startsWith(AppRouteNames.profile)) return 1;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouteNames.home);
        break;
      case 1:
        context.go(AppRouteNames.profile);
        break;
    }
  }
}