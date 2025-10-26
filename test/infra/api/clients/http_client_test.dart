import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../../helpers/fakes.dart';
import 'client_spy.dart';

class HttpClient {
  final Client client;
  HttpClient({required this.client});

  Future<void> get({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
  }) async {
    final allHeaders = (headers ?? {})
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
      });
    final uri = _buildUri(url: url, params: params, queryString: queryString);
    await client.get(uri, headers: allHeaders);
  }

  Uri _buildUri({
    required String url,
    Map<String, String?>? params,
    Map<String, String>? queryString,
  }) {
    params?.forEach(
      (key, value) => url = url.replaceFirst(':$key', value ?? ''),
    );
    if (url.endsWith('/')) url = url.substring(0, url.length - 1);
    if (queryString != null) {
      url += '?';
      queryString.forEach((key, value) => url += '$key=$value&');
      url = url.substring(0, url.length - 1);
    }
    return Uri.parse(url);
  }
}

void main() {
  late ClientSpy client;
  late HttpClient sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpClient(client: client);
    url = anyString();
  });
  group('get', () {
    test('should request with correct method', () async {
      await sut.get(url: url);
      expect(client.method, 'get');
      expect(client.callsCount, 1);
    });

    test('should request with correct url', () async {
      await sut.get(url: url);
      expect(client.url, url);
    });

    test('should request with default headers', () async {
      await sut.get(url: url);
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
    });

    test('should append headers', () async {
      await sut.get(
        url: url,
        headers: {
          'custom-header1': 'custom-value1',
          'custom-header2': 'custom-value2',
        },
      );
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
      expect(client.headers?['custom-header1'], 'custom-value1');
      expect(client.headers?['custom-header2'], 'custom-value2');
    });

    test('should request with correct params', () async {
      url = 'http://anyurl.com/:param1/:param2';
      await sut.get(url: url, params: {'param1': 'value1', 'param2': 'value2'});
      expect(client.url, 'http://anyurl.com/value1/value2');
    });

    test('should request with optional param', () async {
      url = 'http://anyurl.com/:param1/:param2';
      await sut.get(url: url, params: {'param1': 'value1', 'param2': null});
      expect(client.url, 'http://anyurl.com/value1');
    });

    test('should request with invalid param', () async {
      url = 'http://anyurl.com/:param1/:param2';
      await sut.get(url: url, params: {'param3': 'value3'});
      expect(client.url, 'http://anyurl.com/:param1/:param2');
    });

    test('should request with correct queryStrings', () async {
      await sut.get(
        url: url,
        queryString: {'query1': 'value1', 'query2': 'value2'},
      );
      expect(client.url, '$url?query1=value1&query2=value2');
    });

    test('should request with correct queryStrings and params', () async {
      url = 'http://anyurl.com/:param3/:param4';
      await sut.get(
        url: url,
        queryString: {'query1': 'value1', 'query2': 'value2'},
        params: {'param3': 'value3', 'param4': 'value4'},
      );
      expect(
        client.url,
        'http://anyurl.com/value3/value4?query1=value1&query2=value2',
      );
    });
  });
}
