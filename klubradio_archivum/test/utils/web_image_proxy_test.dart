import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/utils/web_image_proxy.dart';

void main() {
  // In the test environment kIsWeb is always false, so transform() returns
  // the original URL for any non-null/non-empty input.

  group('WebImageProxy.transform', () {
    test('returns empty string for null input', () {
      expect(WebImageProxy.transform(null), '');
    });

    test('returns empty string for empty string input', () {
      expect(WebImageProxy.transform(''), '');
    });

    test('returns original URL for non-klubradio URL (kIsWeb=false)', () {
      const url = 'https://example.com/image.jpg';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for klubradio URL because kIsWeb is false', () {
      const url =
          'https://www.klubradio.hu/data/musorkepek/nagy/some_image.jpeg';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for klubradio.hu host variant', () {
      const url = 'https://klubradio.hu/images/cover.png';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for images.klubradio.hu variant', () {
      const url = 'https://images.klubradio.hu/photo.jpg';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for cdn.klubradio.hu variant', () {
      const url = 'https://cdn.klubradio.hu/assets/logo.png';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original string for invalid/unparseable URL', () {
      const badUrl = ':::not-a-valid-url';
      expect(WebImageProxy.transform(badUrl), badUrl);
    });

    test('returns original for data URI', () {
      const dataUri = 'data:image/png;base64,iVBORw0KGgo=';
      expect(WebImageProxy.transform(dataUri), dataUri);
    });

    test('returns original for plain text that is not a URL', () {
      const text = 'just some text';
      expect(WebImageProxy.transform(text), text);
    });
  });
}
