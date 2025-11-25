import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Zeigt bevorzugt ein lokales Bild (Dateipfad), andernfalls eine URL.
/// Fällt bei Fehlern auf ein Icon im Container zurück.
///
/// - [path]  : absoluter Dateipfad (z. B. aus cachedImagePath)
/// - [url]   : Netzwerk-URL (HTTP/HTTPS)
/// - [preferLocal] : true ⇒ wenn [path] existiert, wird es genutzt
///
/// Mindestens eines von [path] oder [url] sollte gesetzt sein.
/// Auf Web wird [path] ignoriert (da kein direkter Dateizugriff).
class ImageUrl extends StatelessWidget {
  const ImageUrl({
    super.key,
    this.path,
    this.url,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.icon = Icons.podcasts_outlined,
    this.fit = BoxFit.cover,
    this.preferLocal = true,
  });

  /// Absoluter Dateipfad (z. B. `C:\Users\...\52775.jpg` oder `/data/.../52775.jpg`)
  final String? path;

  /// Netzwerk-URL
  final String? url;

  final double? width;
  final double? height;
  final double borderRadius;
  final IconData icon;
  final BoxFit fit;

  /// True ⇒ lokales Bild hat Vorrang, wenn vorhanden.
  final bool preferLocal;

  bool get _hasValidUrl {
    final u = url ?? '';
    if (u.isEmpty) return false;
    final parsed = Uri.tryParse(u);
    return parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https') &&
        (parsed.host.isNotEmpty);
  }

  bool get _hasUsablePath {
    if (kIsWeb) return false; // auf Web keine Dateisystemzugriffe
    final p = path ?? '';
    if (p.isEmpty) return false;
    try {
      return File(p).existsSync();
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = width ?? 72.0;
    final h = height ?? 72.0;

    Widget fallback([Color? color]) => Container(
      width: w,
      height: h,
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: Icon(icon, size: w * 0.5),
    );

    Widget clip(Widget child) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );

    // Handle asset images first
    if (url != null && url!.startsWith('assets/')) {
      return clip(
        Image.asset(
          url!,
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    // Priorität: lokal (wenn preferLocal & vorhanden) → URL → Fallback
    if (preferLocal && _hasUsablePath) {
      return clip(
        Image.file(
          File(path!),
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    if (_hasValidUrl) {
      return clip(
        Image.network(
          url!,
          width: w,
          height: h,
          fit: fit,
          // Leichtgewichtiger Placeholder beim Laden
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return fallback(Theme.of(ctx).colorScheme.surfaceContainerHighest);
          },
          // Bei 404/Netz/Decode-Fehlern: Fallback statt rotem Fehler
          errorBuilder: (ctx, error, stack) => fallback(),
        ),
      );
    }

    // Wenn URL nicht valide oder kein lokales Bild verfügbar ist:
    // ggf. trotzdem lokales Bild versuchen (falls preferLocal=false)
    if (!preferLocal && _hasUsablePath) {
      return clip(
        Image.file(
          File(path!),
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    return clip(fallback());
  }
}
