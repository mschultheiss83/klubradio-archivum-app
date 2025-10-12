import 'package:flutter/material.dart';

class ImageUrl extends StatelessWidget {
  const ImageUrl({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.icon = Icons.podcasts_outlined,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final double borderRadius;
  final IconData icon;
  final BoxFit fit;

  bool get _looksValid =>
      url.isNotEmpty &&
      Uri.tryParse(url)?.hasScheme == true &&
      Uri.tryParse(url)?.hasAuthority == true;

  @override
  Widget build(BuildContext context) {
    final w = width ?? 72.0;
    final h = height ?? 72.0;

    Widget fallback([Color? color]) => Container(
      width: w,
      height: h,
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      child: Icon(icon, size: w * 0.5),
    );

    // Guard against empty / malformed URLs early.
    if (!_looksValid) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: fallback(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: w,
        height: h,
        fit: fit,

        // While loading: show a lightweight placeholder.
        loadingBuilder: (ctx, child, progress) {
          if (progress == null) return child;
          return fallback(Theme.of(ctx).colorScheme.surfaceVariant);
        },

        // On 404 / network / decode errors: show fallback instead of red error box.
        errorBuilder: (ctx, error, stack) => fallback(),
      ),
    );
  }
}
