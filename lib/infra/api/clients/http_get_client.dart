import 'package:advanced_flutter/infra/types/json.dart';

abstract class HttpGetClient {
  Future<dynamic> get<T>({required String url, Json? params});
}
