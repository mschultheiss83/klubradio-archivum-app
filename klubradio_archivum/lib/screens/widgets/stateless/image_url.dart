import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/utils/web_image_proxy.dart';

/// Zeigt bevorzugt ein lokales Bild (Dateipfad), andernfalls eine URL.
/// Fällt bei Fehlern auf ein Icon im Container zurück.
///
/// - [path]  : absoluter Dateipfad (z. B. aus cachedImagePath)
/// - [url]   : Netzwerk-URL (HTTP/HTTPS)
/// - [preferLocal] : true ⇒ wenn [path] existiert, wird es genutzt
///
/// Mindestens eines von [path] oder [url] sollte gesetzt sein.
/// Auf Web wird [path] ignoriert (da kein direkter Dateizugriff).
class ImageUrl extends StatefulWidget {
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
    this.backgroundColor,
    this.loadingBackgroundColor,
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

  /// Background color for the fallback/error state.
  final Color? backgroundColor;

  /// Background color for the loading placeholder.
  final Color? loadingBackgroundColor;

  @override
  State<ImageUrl> createState() => _ImageUrlState();
}

class _ImageUrlState extends State<ImageUrl> {
  /// Cached result of the async file-existence check.
  /// null means the check hasn't completed yet.
  bool? _pathExists;

  @override
  void initState() {
    super.initState();
    _checkPath();
  }

  @override
  void didUpdateWidget(ImageUrl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _pathExists = null;
      _checkPath();
    }
  }

  void _checkPath() {
    if (kIsWeb || (widget.path ?? '').isEmpty) {
      _pathExists = false;
      return;
    }
    // Perform async I/O off the UI thread.
    File(widget.path!).exists().then((exists) {
      if (mounted) setState(() => _pathExists = exists);
    }).catchError((_) {
      if (mounted) setState(() => _pathExists = false);
    });
  }

  bool get _hasValidUrl {
    final u = widget.url ?? '';
    if (u.isEmpty) return false;
    final parsed = Uri.tryParse(u);
    return parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https') &&
        (parsed.host.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 72.0;
    final h = widget.height ?? 72.0;
    final baseBackgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.primaryContainer;
    final resolvedLoadingBackgroundColor = widget.loadingBackgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    Widget fallback([Color? color]) => Container(
      width: w,
      height: h,
      color: color ?? baseBackgroundColor,
      alignment: Alignment.center,
      child: Icon(widget.icon, size: w * 0.5),
    );

    Widget clip(Widget child) => ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: child,
    );

    // Handle asset images first
    if (widget.url != null && widget.url!.startsWith('assets/')) {
      return clip(
        Image.asset(
          widget.url!,
          width: w,
          height: h,
          fit: widget.fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    final bool pathUsable = _pathExists ?? false;

    // Priorität: lokal (wenn preferLocal & vorhanden) → URL → Fallback
    if (widget.preferLocal && pathUsable) {
      return clip(
        Image.file(
          File(widget.path!),
          width: w,
          height: h,
          fit: widget.fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    if (_hasValidUrl) {
      // Transform URL for web platform to avoid CORS issues
      final imageUrl = WebImageProxy.transform(widget.url!);

      return clip(
        Image.network(
          imageUrl,
          width: w,
          height: h,
          fit: widget.fit,
          // Leichtgewichtiger Placeholder beim Laden
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return fallback(resolvedLoadingBackgroundColor);
          },
          // Bei 404/Netz/Decode-Fehlern: Fallback statt rotem Fehler
          errorBuilder: (ctx, error, stack) => fallback(),
        ),
      );
    }

    // Wenn URL nicht valide oder kein lokales Bild verfügbar ist:
    // ggf. trotzdem lokales Bild versuchen (falls preferLocal=false)
    if (!widget.preferLocal && pathUsable) {
      return clip(
        Image.file(
          File(widget.path!),
          width: w,
          height: h,
          fit: widget.fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    return clip(fallback());
  }
}
