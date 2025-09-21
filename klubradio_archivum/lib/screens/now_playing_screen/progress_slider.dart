import 'package:flutter/material.dart';

import '../utils/helpers.dart';

typedef PositionChangedCallback = void Function(Duration position);

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({
    super.key,
    required this.position,
    required this.duration,
    required this.onChanged,
  });

  final Duration position;
  final Duration duration;
  final PositionChangedCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final double value = duration.inMilliseconds == 0
        ? 0
        : position.inMilliseconds / duration.inMilliseconds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Slider(
          value: value.clamp(0, 1),
          onChanged: duration == Duration.zero
              ? null
              : (double newValue) {
                  final int milliseconds =
                      (newValue * duration.inMilliseconds).round();
                  onChanged(Duration(milliseconds: milliseconds));
                },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(formatDuration(position)),
            Text(formatDuration(duration)),
          ],
        ),
      ],
    );
  }
}
