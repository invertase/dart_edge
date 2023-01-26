import 'dart:math';

import 'package:v8_runtime/v8_runtime.dart';
import 'package:test/test.dart';

void main() {
  group('Request', () {
    test('.method', () {
      final resource = Resource('https://foo.com');

      expect(
        Request(resource).method,
        'GET',
        reason: 'The default method is should be GET',
      );

      expect(Request(resource, RequestInit(method: 'GET')).method, 'GET');
      expect(Request(resource, RequestInit(method: 'POST')).method, 'POST');
      expect(
          Request(resource, RequestInit(method: 'OPTIONS')).method, 'OPTIONS');
    });

    test('.url', () {
      // Browser adds a / to the path if empty
      final uri = Uri.parse('https://foo.com/');
      final resource = Resource.uri(uri);

      expect(Request(resource).url, uri);
      expect(Request(Resource('https://foo.com?foo=bar')).url.queryParameters, {
        'foo': 'bar',
      });
    });

    test('.headers', () {
      final request = Request(
        Resource(
          'https://foo.com',
        ),
        RequestInit(
          headers: Headers({
            'foo': 'bar',
          }),
        ),
      );

      expect(request.headers['foo'], 'bar');
    });

    test('.destination', () {
      final request = Request(
        Resource(
          'https://foo.com',
        ),
        RequestInit(
          destination: RequestDestination.document,
        ),
      );

      expect(request.headers['foo'], 'bar');
    });
  });
}
