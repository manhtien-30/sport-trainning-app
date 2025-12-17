import 'dart:io';

import 'package:core/src/data/network/interface/base_client_generator.dart';
import 'package:core/src/data/network/network_options.dart';

import '../../../../core.dart';

class NetworkCreator {
  static var shared = NetworkCreator();
  final Dio _client = Dio();

  Future<Response> request({
    required BaseClientGenerator route,
    NetworkOptions? options,
  }) {
    return _client.fetch(
      RequestOptions(
        baseUrl: route.baseURL,
        method: route.method,
        path: route.path,
        queryParameters: route.queryParameters,
        data: route.body,
        sendTimeout: Duration(milliseconds: route.sendTimeout ?? 30000),
        receiveTimeout: Duration(milliseconds: route.sendTimeout ?? 30000),
        onReceiveProgress: options?.onReceiveProgress,
        validateStatus: (statusCode) =>
            (statusCode! >= HttpStatus.ok &&
            statusCode <= HttpStatus.multipleChoices),
      ),
    );
  }
}
