import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';

import 'download_list.dart';

class DownloadManagerScreen extends StatelessWidget {
  const DownloadManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppDatabase, DownloadProvider>(
      builder: (context, db, dlProv, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          dlProv.settingsDao.ensureDefaults();
        });
        final l10n = AppLocalizations.of(context)!; // Get l10n instance

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.downloadListTitle, // Localized title
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Expanded(child: DownloadList()),
            ],
          ),
        );
      },
    );
  }
}
