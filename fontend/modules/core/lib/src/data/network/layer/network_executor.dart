import 'package:core/core.dart';
import 'package:core/src/data/network/interface/base_client_generator.dart';
import 'package:core/src/data/network/interface/base_network_model.dart';
import 'package:core/src/data/network/layer/network_connectivity.dart';
import 'package:core/src/data/network/layer/network_creator.dart';
import 'package:core/src/data/network/layer/network_decoder.dart';
import 'package:core/src/data/network/network_options.dart';
import 'package:core/src/data/network/wrapper/network_errors.dart';
import 'package:core/src/data/network/wrapper/result.dart';

class NetworkExecutor {
  static bool debugMode = true;

  static Future<Result<K, NetworkError>>
  executed<T extends BaseNetworkModel, K>({
    required BaseClientGenerator route,
    required T responseType,
    NetworkOptions? networkOption,
  }) async {
    if (debugMode) print(route);
    if (await NetworkConnectivity.status) {
      try {
        var response = await NetworkCreator.shared.request(
          route: route,
          options: networkOption,
        );
        var data = NetworkDecoder().decode<T, K>(
          response: response,
          responseType: responseType,
        );
        return Result.success(data);
      } on DioException catch (dioError) {
        return Result.failure(NetworkError.request(error: dioError));
      } on TypeError catch (typeError) {
        return Result.failure(NetworkError.type(error: typeError.toString()));
      }
    } else {
      if (debugMode) print(NetworkError.connectivity(message: "no connection"));
      return Result.failure(
        NetworkError.connectivity(message: "no connection"),
      );
    }
  }
}
