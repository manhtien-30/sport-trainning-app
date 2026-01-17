import 'package:core/src/module/base_module.dart';
import 'package:flutter/widgets.dart';
import 'package:core/libs.dart';
import 'data/data_injection.dart';
import 'domain/order_repository.dart';

part 'order_module_impl.dart';

abstract class OrderModule extends BaseModule {
  static final OrderModule _instance = _OrderModuleImpl();

  static OrderModule get instance => _instance;

  Future<DeliveryOrder> createDeliveryOrder(CreateDeliveryOrderParams params);
}
