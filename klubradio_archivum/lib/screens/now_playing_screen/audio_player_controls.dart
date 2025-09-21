import 'package:flutter/material.dart';

class AudioPlayerControls extends StatelessWidget {
  const AudioPlayerControls({
    super.key,
    required this.isPlaying,
    required this.onTogglePlayPause,
    required this.onRewind,
    required this.onForward,
  });

  final bool isPlaying;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.replay_10),
          onPressed: onRewind,
        ),
        const SizedBox(width: 24),
        FilledButton.tonalIcon(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          label: Text(isPlaying ? 'Szünet' : 'Lejátszás'),
          onPressed: onTogglePlayPause,
        ),
        const SizedBox(width: 24),
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.forward_30),
          onPressed: onForward,
        ),
      ],
    );
  }
}
