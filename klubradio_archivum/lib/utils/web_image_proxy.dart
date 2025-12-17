import 'package:flutter/foundation.dart' show kIsWeb;

/// Handles CORS-compliant image URLs for Flutter Web.
///
/// On web platform, external images from klubradio.hu cause CORS errors.
/// This utility proxies images through a CORS-enabled service.
class WebImageProxy {
  /// Transforms an image URL to use a CORS proxy on web platform.
  ///
  /// - On web: Routes klubradio.hu images through a proxy
  /// - On mobile/desktop: Returns original URL unchanged
  ///
  /// Example:
  /// ```dart
  /// final url = WebImageProxy.transform('https://www.klubradio.hu/data/musorkepek/foo.jpeg');
  /// Image.network(url); // Works on all platforms
  /// ```
  static String transform(String? originalUrl) {
    if (originalUrl == null || originalUrl.isEmpty) {
      return '';
    }

    // On non-web platforms, use original URL
    if (!kIsWeb) {
      return originalUrl;
    }

    // Check if this is a klubradio.hu image URL
    final uri = Uri.tryParse(originalUrl);
    if (uri == null || !_isKlubradioImage(uri)) {
      return originalUrl;
    }

    // Use Supabase Edge Function for CORS-enabled image proxying
    return _proxyViaSupabase(originalUrl);
  }

  /// Checks if the URL is a klubradio.hu image
  static bool _isKlubradioImage(Uri uri) {
    final host = uri.host.toLowerCase();
    return host == 'www.klubradio.hu' ||
        host == 'klubradio.hu' ||
        host == 'images.klubradio.hu' ||
        host == 'cdn.klubradio.hu';
  }

  /// Routes image through Supabase Edge Function with CORS support
  static String _proxyViaSupabase(String originalUrl) {
    const functionUrl =
        'https://arakbotxgwpyyqyxjhhl.supabase.co/functions/v1/image-proxy';
    return '$functionUrl?url=${Uri.encodeComponent(originalUrl)}';
  }
}
