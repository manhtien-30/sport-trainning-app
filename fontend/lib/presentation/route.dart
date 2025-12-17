import 'package:flutter/cupertino.dart';
import 'package:fontend/presentation/screens/home-screen.dart';
import 'package:fontend/presentation/ui/main_wrapper.dart';
import 'package:go_router/go_router.dart';

class AppRouteNames {
  static const splash = "/";
  static const home = "/home";
  static const login = "/login";
  static const profile = "/profile";
}

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteNames.home,
    redirect: (context, state) {
      return null;
    },
    routes: [
      // Cau hinh route vao screen Login
      GoRoute(
        path: AppRouteNames.login,
        builder: (context, state) => HomePage(),
      ),
      // Cau hinh route chinh bottom bar
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return MainWrapper(child: child);
        },
        routes: [GoRoute(path: AppRouteNames.home)],
      ),
    ],
  );
}
