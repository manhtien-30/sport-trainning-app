import 'package:core/src/module/base_module.dart';
import 'package:flutter/widgets.dart';
import 'data/data_injection.dart';

part 'payment_module_impl.dart';

abstract class PaymentModule extends BaseModule {
  static final PaymentModule _instance = _PaymentModuleImpl();

  static PaymentModule get instance => _instance;
}
