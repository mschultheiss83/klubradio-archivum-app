import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'download_list.dart';

class DownloadManagerScreen extends StatelessWidget {
  const DownloadManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
        title: Text('Letöltések'),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: DownloadList(),
      ),
    );
  }
}
