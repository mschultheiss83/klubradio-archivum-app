// lib/providers/subscription_provider.dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    required this.subscriptionsDao,
    required this.downloadProvider,
  });

  final SubscriptionsDao subscriptionsDao;
  DownloadProvider downloadProvider; // Make it non-final to allow updating

  Subscription? _currentSubscription;
  Subscription? get currentSubscription => _currentSubscription;

  bool _busy = false;
  bool get busy => _busy;

  void updateDependencies({
    required DownloadProvider downloadProvider,
  }) {
    if (this.downloadProvider != downloadProvider) {
      this.downloadProvider = downloadProvider;
    }
  }

  Future<void> loadSubscription(String podcastId) async {
    _currentSubscription = await subscriptionsDao.getById(podcastId);
    notifyListeners();
  }

  Stream<Subscription?> watchSubscription(String podcastId) {
    return subscriptionsDao.watchOne(podcastId);
  }

  Future<void> toggleSubscription(String podcastId, bool isSubscribed) async {
    debugPrint(
      'toggleSubscription: podcastId=$podcastId, isSubscribed=$isSubscribed, busy=true',
    );
    _busy = true;
    notifyListeners();
    try {
      await subscriptionsDao.toggleSubscribe(
        podcastId: podcastId,
        active: !isSubscribed,
      );
      _currentSubscription = await subscriptionsDao.getById(podcastId);
      debugPrint(
        'toggleSubscription: subscriptionsDao.toggleSubscribe completed',
      );

      if (!isSubscribed) {
        final downloadCount = await downloadProvider.autodownloadPodcast(
          podcastId,
        );
        debugPrint(
          'toggleSubscription: autodownload called, downloading files: $downloadCount',
        );
      }
    } catch (e) {
      debugPrint('toggleSubscription: Error: $e');
      rethrow; // Re-throw the error so it can be caught by the UI
    } finally {
      _busy = false;
      notifyListeners();
      debugPrint('toggleSubscription: busy=false, notifyListeners called');
    }
  }
}
