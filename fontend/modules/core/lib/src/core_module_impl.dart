part of 'core_module.dart';

class _CoreModuleImpl extends CoreModule {
  _CoreModuleImpl();

  @override
  Future<void> inject() async {
    return DataInjection().inject(GetIt.instance.get<CoreEnvironment>());
  }

  @override
  // TODO: implement locallizationsDelegates
  List<LocalizationsDelegate> get locallizationsDelegates =>
      throw UnimplementedError();
}
