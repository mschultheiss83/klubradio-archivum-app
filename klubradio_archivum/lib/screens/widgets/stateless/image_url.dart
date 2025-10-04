import 'package:flutter/material.dart';

class CoverArt extends StatelessWidget {
  const CoverArt({super.key, required this.imageUrl, IconData? icon});

  final String imageUrl;
  final IconData? icon = null;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl.isEmpty
          ? Container(
              width: 72,
              height: 72,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: icon != null
                  ? Icon(icon)
                  : const Icon(Icons.podcasts_outlined),
            )
          : Image.network(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Container(
                      width: 72,
                      height: 72,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: icon != null
                          ? Icon(icon)
                          : const Icon(Icons.podcasts_outlined),
                    );
                  },
            ),
    );
  }
}
