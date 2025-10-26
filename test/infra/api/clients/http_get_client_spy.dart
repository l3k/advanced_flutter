import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Map<String, String?>? params;
  Map<String, String>? headers;
  Map<String, String?>? queryString;
  dynamic response;
  Error? error;

  @override
  Future<dynamic> get({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
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
