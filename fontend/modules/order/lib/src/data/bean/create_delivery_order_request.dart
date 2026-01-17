import 'package:core/core.dart';
import 'package:auth/auth.dart';
import '../../domain/order_repository.dart';

class CreateDeliveryOrderRequest extends BaseClientGenerator {
  final CreateDeliveryOrderParams params;

  CreateDeliveryOrderRequest(this.params);

  @override
  String get baseURL => GetIt.instance.get<CoreEnvironment>().baseUrl;

  @override
  dynamic get body => params.toJson();

  @override
  Map<String, dynamic> get header {
    final auth = GetIt.instance.get<AuthenticationRepository>();
    final token = auth.currentUser?.token;
    final type = auth.currentUser?.type ?? 'Bearer';
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': '$type $token',
    };
  }

  @override
  String get method => 'POST';

  @override
  String get path => '/orders/delivery';

  @override
  Map<String, dynamic>? get queryParameters => null;
}
