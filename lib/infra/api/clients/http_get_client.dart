abstract interface class HttpGetClient {
  Future<dynamic> get({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
  });
}
