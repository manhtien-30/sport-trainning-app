part of 'profile_module.dart';

class _ProfileModuleImpl extends ProfileModule {
  _ProfileModuleImpl();

  @override
  Future<void> inject() async {
    await ProfileDataInjection().inject();
  }

  @override
  List<LocalizationsDelegate<dynamic>> get locallizationsDelegates => const [];
}
