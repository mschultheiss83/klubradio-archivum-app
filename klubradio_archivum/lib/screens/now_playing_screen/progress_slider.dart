import 'package:flutter/material.dart';

import '../../providers/episode.provider.dart';
import '../utils/helpers.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    final Duration position = provider.currentPosition;
    final Duration total = provider.totalDuration ?? Duration.zero;
    final double maxSeconds = total.inSeconds > 0 ? total.inSeconds.toDouble() : 1;
    final double value = position.inSeconds.clamp(0, total.inSeconds).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Slider(
          value: value,
          max: maxSeconds,
          onChanged: (double newValue) {
            provider.seek(Duration(seconds: newValue.toInt()));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(formatDuration(position)),
            Text(formatDuration(total)),
          ],
        ),
      ],
    );
  }
}
