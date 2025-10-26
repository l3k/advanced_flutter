import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../../helpers/fakes.dart';
import 'client_spy.dart';

class HttpClient {
  final Client client;
  HttpClient({required this.client});

  Future<void> get({required String url, Map<String, String>? headers}) async {
    final allHeaders = (headers ?? {})
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
      });
    await client.get(Uri.parse(url), headers: allHeaders);
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
  });
}
