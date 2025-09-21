import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import 'download_list.dart';

class DownloadManagerScreen extends StatelessWidget {
  const DownloadManagerScreen({super.key});

  static const String routeName = '/downloads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Letöltések')),
      body: Consumer<EpisodeProvider>(
        builder: (BuildContext context, EpisodeProvider provider, _) {
          return DownloadList(downloads: provider.downloads);
        },
      ),
    );
  }
}
