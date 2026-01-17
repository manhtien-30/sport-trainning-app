import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frontend/environment/environment.dart';
import 'package:frontend/presentation/localization/AppLocalization.dart';
import 'package:frontend/presentation/route.dart';
import 'package:frontend/presentation/screens/home-screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void startApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig.env.modules.initEnv();
  await FlavorConfig.env.modules.inject();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp.router(
        title: "Super App",
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        routerConfig: AppRouter.router,
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'en'),
          Locale.fromSubtags(languageCode: 'vi'),
        ],
        // initialRoute: AppRouteNames.home,
        // getPages: [...MainRouter.pages],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalization.delegate,
          ...FlavorConfig.env.modules.localizationsDelegates,
        ],
      ),
    );
  }
}
