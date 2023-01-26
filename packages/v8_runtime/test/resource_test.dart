import 'package:v8_runtime/v8_runtime.dart';
import 'package:test/test.dart';

void main() {
  group('Resource', () {
    test('Resource()', () {
      final resource = Resource('https://foo.com');

      resource.when(
        (url) => expect(url, 'https://foo.com'),
        uri: (uri) => fail('Should not be called'),
        request: (request) => fail('Should not be called'),
      );
    });

    test('.uri()', () {
      final resource = Resource.uri(Uri.parse('https://foo.com'));

      resource.when(
        (url) => fail('Should not be called'),
        uri: (uri) => expect(uri, Uri.parse('https://foo.com')),
        request: (request) => fail('Should not be called'),
      );
    });

    test('.request()', () {
      final resource = Resource.request(Request(Resource('https://foo.com')));

      resource.when(
        (url) => fail('Should not be called'),
        uri: (uri) => fail('Should not be called'),
        request: (request) =>
            expect(request.url.toString(), 'https://foo.com/'),
      );
    });
  });
}
