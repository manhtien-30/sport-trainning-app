import 'package:flutter/cupertino.dart';
import 'package:frontend/presentation/screens/home-screen.dart';
import 'package:profile/src/presentation/ui/screen/profile_screen.dart';
import 'package:frontend/presentation/screens/splash_screen.dart';
import 'package:frontend/presentation/ui/main_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:core/libs.dart';
import 'package:auth/auth.dart';
import 'package:auth/src/domain/authentication_repository.dart';
import 'package:frontend/presentation/screens/driver_home_screen.dart';
import 'package:payment/payment.dart';
import 'package:order/order.dart';
import 'package:order/src/presentation/ui/order_history_list_screen.dart';

class AppRouteNames {
  static const splash = "/";
  static const home = "/home";
  static const login = "/login";
  static const profile = "/profile";
  static const order = "/order";
  // New entry route for creating delivery orders
  static const orderCreateDelivery = "/order/create-delivery";
  // Legacy entry route kept for backward compatibility
  static const orderDelivery = "/order/delivery";
  static const orderDeliveryAddress = "/order/delivery/address";
  static const orderDeliveryVehicle = "/order/delivery/vehicle";
  static const orderDeliveryPackage = "/order/delivery/package";
  static const orderDeliveryPrice = "/order/delivery/price";
  static const orderDeliveryOverview = "/order/delivery/overview";
  static const orderDeliveryTracking = "/order/delivery/tracking";
  static const orderDeliveryFinal = "/order/delivery/final";
  static const orderListHistory = "/order/list-history";
  static const driverHome = "/driverHome";
  static const payment = "/payment";
}
// class MainRouter{
//   static final pages = [
//     // GetPage(
//     //     name: AppRouteNames.splash,
//     //     page: () => const SplashScreen(),
//     //     binding: SplashBinding()),
//     GetPage(
//         name: AppRouteNames.home,
//         page: () => const HomePage(),
//         transitionDuration: const Duration(seconds: 011)),
//   ];
// }
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteNames.splash,
    redirect: (context, state) {
      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        path: AppRouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // Login route
      GoRoute(
        path: AppRouteNames.login,
        builder: (context, state) {
          final repo = GetIt.I.get<AuthenticationRepository>();
          return LoginScreen(authenticationRepository: repo);
        },
      ),
      // Signup route
      AuthRoutes.signUpRoute(),
      // Main shell with bottom bar
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return MainWrapper(child: child);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: shellNavigatorKey, // Render bên trong Shell
            path: AppRouteNames.home,
            builder: ((context, state) => const HomePage()),
          ),

          GoRoute(
            parentNavigatorKey: shellNavigatorKey, // Render bên trong Shell
            path: AppRouteNames.profile,
            builder: ((context, state) => const ProfilePage()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.driverHome,
            builder: ((context, state) => const DriverHomeScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.payment,
            builder: ((context, state) => const PaymentScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderCreateDelivery,
            builder: ((context, state) => const DeliveryOverviewStepScreen()),
          ),
          // Legacy path kept temporarily to avoid breaking existing links
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDelivery,
            builder: ((context, state) => const DeliveryOrderFormScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryAddress,
            builder: ((context, state) => const DeliveryAddressStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryVehicle,
            builder: ((context, state) => const DeliveryVehicleSelectionStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryPackage,
            builder: ((context, state) => const DeliveryPackageDetailsStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryPrice,
            builder: ((context, state) => const DeliveryPriceEstimateStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryOverview,
            builder: ((context, state) => const DeliveryOverviewStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryTracking,
            builder: ((context, state) => const DeliveryTrackingStepScreen()),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderDeliveryFinal,
            builder: ((context, state) => DeliveryOrderFinalScreen(orderFromExtra: state.extra is DeliveryOrder ? state.extra as DeliveryOrder : null)),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: AppRouteNames.orderListHistory,
            builder: ((context, state) => const OrderHistoryListScreen()),
          ),
        ],
      ),
    ],
  );
}
