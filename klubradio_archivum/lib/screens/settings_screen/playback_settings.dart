import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../utils/constants.dart';

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final currentValue = provider.maxAutoDownloadEpisodes.toDouble();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Lejátszás és letöltés', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: kSmallPadding),
                Text(
                  'Állítsd be, hogy hány új epizód töltődjön le automatikusan a feliratkozott műsorokból.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: kSmallPadding),
                Slider(
                  value: currentValue,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: provider.maxAutoDownloadEpisodes.toString(),
                  onChanged: (value) => provider
                      .setMaxAutoDownloadEpisodes(value.round()),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${provider.maxAutoDownloadEpisodes} epizód',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
