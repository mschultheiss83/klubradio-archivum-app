import 'package:flutter/material.dart';

class CoverArt extends StatelessWidget {
  const CoverArt({
    super.key,
    required this.imageUrl,
    this.icon,
    this.width,
    this.height,
  });

  final String imageUrl;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double displayWidth = width ?? 72;
    final double displayHeight = height ?? 72;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl.isEmpty
          ? Container(
              width: displayWidth,
              height: displayHeight,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                icon ?? Icons.podcasts_outlined,
                size: displayWidth * 0.5,
              ),
            )
          : Image.network(
              imageUrl,
              width: displayWidth,
              height: displayHeight,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Container(
                      width: displayWidth,
                      height: displayHeight,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        icon ?? Icons.podcasts_outlined,
                        size: displayWidth * 0.5,
                      ),
                    );
                  },
            ),
    );
  }
}
