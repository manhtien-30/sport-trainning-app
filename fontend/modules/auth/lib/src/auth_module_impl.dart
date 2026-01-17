part of 'auth_module.dart';

class _AuthModuleImpl extends AuthModule {
  _AuthModuleImpl();

  @override
  Future<void> inject() async {
    await AuthDataInjection().inject();
  }

  @override
  List<LocalizationsDelegate<dynamic>> get locallizationsDelegates => AppLocalizationImp.localizationsDelegates;
}
