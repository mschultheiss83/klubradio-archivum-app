import 'package:flutter/material.dart';

import '../utils/helpers.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({
    super.key,
    required this.positionNotifier,
    required this.totalDuration,
    required this.onSeek,
  });

  final ValueNotifier<Duration> positionNotifier;
  final Duration totalDuration;
  final Function(Duration) onSeek;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: positionNotifier,
      builder: (context, position, child) {
        final double maxSeconds = totalDuration.inSeconds > 0
            ? totalDuration.inSeconds.toDouble()
            : 1.0;
        final double value = position.inSeconds
            .clamp(0, totalDuration.inSeconds)
            .toDouble();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider(
              value: value,
              max: maxSeconds,
              onChanged: (double newValue) {
                onSeek(Duration(seconds: newValue.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(formatDurationPrecise(position)),
                Text(formatDurationPrecise(totalDuration)),
              ],
            ),
          ],
        );
      },
    );
  }
}

