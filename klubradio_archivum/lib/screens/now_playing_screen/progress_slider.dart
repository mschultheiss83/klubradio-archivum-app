import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../utils/helpers.dart';

class ProgressSlider extends StatefulWidget {
  const ProgressSlider({super.key});

  @override
  State<ProgressSlider> createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final episode = provider.nowPlaying;
        final duration = episode?.duration ?? Duration.zero;
        final durationSeconds = duration.inSeconds;
        final currentPosition = _dragValue != null
            ? Duration(seconds: _dragValue!.round())
            : provider.currentPosition;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Slider(
              value: durationSeconds == 0
                  ? 0
                  : currentPosition.inSeconds
                      .clamp(0, durationSeconds)
                      .toDouble(),
              min: 0,
              max: durationSeconds == 0 ? 1 : durationSeconds.toDouble(),
              onChanged: episode == null
                  ? null
                  : (value) {
                      setState(() {
                        _dragValue = value;
                      });
                    },
              onChangeEnd: episode == null
                  ? null
                  : (value) {
                      setState(() {
                        _dragValue = null;
                      });
                      provider.seek(Duration(seconds: value.round()));
                    },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(formatDuration(currentPosition)),
                Text(formatDuration(duration)),
              ],
            ),
          ],
        );
      },
    );
  }
}
