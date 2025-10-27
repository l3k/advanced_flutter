import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';
import 'package:advanced_flutter/infra/types/json.dart';

final class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Json? params;
  Json? headers;
  Json? queryString;
  dynamic response;
  Error? error;

  @override
  Future<dynamic> get({
    required String url,
    Json? headers,
    Json? params,
    Json? queryString,
  }) async {
    this.url = url;
    this.params = params;
    this.headers = headers;
    this.queryString = queryString;
    callsCount++;
    if (error != null) {
      throw error!;
    }
    return response;
  }
}
