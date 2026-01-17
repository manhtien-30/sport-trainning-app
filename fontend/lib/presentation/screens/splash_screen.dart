import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:core/libs.dart';
import 'package:auth/src/domain/authentication_repository.dart';

import '../route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<AuthenticationStatus>? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      FlutterNativeSplash.remove();
      final repo = GetIt.I.get<AuthenticationRepository>();
      // If currentUser already restored and valid, go home; otherwise listen for status
      if (repo.currentUser != null) {
        if (mounted) context.go(AppRouteNames.home);
        return;
      }
      _sub = repo.status.listen((status) {
        if (!mounted) return;
        if (status == AuthenticationStatus.authenticated) {
          context.go(AppRouteNames.home);
        } else if (status == AuthenticationStatus.unauthenticated) {
          context.go(AppRouteNames.login);
        }
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
