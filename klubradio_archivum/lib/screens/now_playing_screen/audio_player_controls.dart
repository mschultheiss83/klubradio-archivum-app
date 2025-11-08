import 'package:flutter/material.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class AudioPlayerControls extends StatelessWidget {
  const AudioPlayerControls({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    final bool hasPrevious = provider.getPreviousEpisode() != null;
    final bool hasNext = provider.getNextEpisode() != null;
    final bool canSeek = provider.currentEpisode != null;

    final List<_SeekOption> seekOptions = const [
      _SeekOption(label: '-2 min', delta: Duration(minutes: -2)),
      _SeekOption(label: '-30 s', delta: Duration(seconds: -30)),
      _SeekOption(label: '-5 s', delta: Duration(seconds: -5)),
      _SeekOption(label: '+5 s', delta: Duration(seconds: 5)),
      _SeekOption(label: '+30 s', delta: Duration(seconds: 30)),
      _SeekOption(label: '+2 min', delta: Duration(minutes: 2)),
    ];

    final List<_SeekOption> leftSeek = seekOptions
        .where((o) => o.delta.isNegative)
        .toList();
    final List<_SeekOption> rightSeek = seekOptions
        .where((o) => !o.delta.isNegative)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              // 1️⃣ Left seek cluster
              _SeekCluster(
                options: leftSeek,
                canSeek: canSeek,
                onTap: (d) => provider.seekRelative(d),
              ),

              // 2️⃣ Transport cluster
              _TransportCluster(
                hasPrevious: hasPrevious,
                hasNext: hasNext,
                isPlaying: provider.isPlaying,
                onPrev: hasPrevious ? provider.playPrevious : null,
                onPlayPause: provider.togglePlayPause,
                onNext: hasNext ? provider.playNext : null,
              ),

              // 3️⃣ Right seek cluster
              _SeekCluster(
                options: rightSeek,
                canSeek: canSeek,
                onTap: (d) => provider.seekRelative(d),
              ),
              // 4️⃣ Speed cluster
              _SpeedCluster(
                speed: provider.playbackSpeed,
                onChanged: (v) => provider.updatePlaybackSpeed(v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeekOption {
  final String label;
  final Duration delta;

  const _SeekOption({required this.label, required this.delta});
}

class _SeekCluster extends StatelessWidget {
  const _SeekCluster({
    required this.options,
    required this.canSeek,
    required this.onTap,
  });

  final List<_SeekOption> options;
  final bool canSeek;
  final void Function(Duration) onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        for (final opt in options)
          _SeekButton(
            label: opt.label,
            onPressed: canSeek ? () => onTap(opt.delta) : null,
          ),
      ],
    );
  }
}

class _TransportCluster extends StatelessWidget {
  const _TransportCluster({
    required this.hasPrevious,
    required this.hasNext,
    required this.isPlaying,
    required this.onPrev,
    required this.onPlayPause,
    required this.onNext,
  });

  final bool hasPrevious;
  final bool hasNext;
  final bool isPlaying;
  final VoidCallback? onPrev;
  final VoidCallback onPlayPause;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 36,
          tooltip: 'Previous Episode',
          icon: const Icon(Icons.skip_previous),
          onPressed: onPrev,
        ),
        IconButton(
          iconSize: 48,
          tooltip: isPlaying ? 'Pause' : 'Play',
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
          onPressed: onPlayPause,
        ),
        IconButton(
          iconSize: 36,
          tooltip: 'Next Episode',
          icon: const Icon(Icons.skip_next),
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _SpeedCluster extends StatelessWidget {
  const _SpeedCluster({required this.speed, required this.onChanged});

  final double speed;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16), // Adjusted spacing
        const Icon(Icons.speed, size: 36),
        const SizedBox(width: 8),
        DropdownButton<double>(
          value: speed,
          underline: const SizedBox.shrink(),
          onChanged: (double? v) {
            if (v != null) onChanged(v);
          },
          items: constants.playbackSpeeds.map((double s) {
            return DropdownMenuItem<double>(value: s, child: Text('${s}x'));
          }).toList(),
        ),
      ],
    );
  }
}

class _SeekButton extends StatelessWidget {
  const _SeekButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
