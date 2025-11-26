// lib/providers/subscription_provider.dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    required this.subscriptionsDao,
    required this.downloadProvider,
  }) {
    _isSubscriptionsSupported = PlatformUtils.supportsSubscriptions;
    // If subscriptions are not supported, make sure the DAO is not actively used
    // or its methods are also no-ops. For now, we guard provider methods.
  }

  final SubscriptionsDao subscriptionsDao;
  DownloadProvider downloadProvider; // Make it non-final to allow updating

  Subscription? _currentSubscription;
  Subscription? get currentSubscription => _currentSubscription;

  bool _busy = false;
  bool get busy => _busy;

  bool _isSubscriptionsSupported = false; // Flag for platform support

  void updateDependencies({
    required DownloadProvider downloadProvider,
  }) {
    if (this.downloadProvider != downloadProvider) {
      this.downloadProvider = downloadProvider;
    }
  }

  Future<void> loadSubscription(String podcastId) async {
    if (!_isSubscriptionsSupported) return;
    _currentSubscription = await subscriptionsDao.getById(podcastId);
    notifyListeners();
  }

  Stream<Subscription?> watchSubscription(String podcastId) {
    if (!_isSubscriptionsSupported) return Stream.value(null); // No-op for unsupported platforms
    return subscriptionsDao.watchOne(podcastId);
  }

  Future<void> toggleSubscription(String podcastId, bool isSubscribed) async {
    if (!_isSubscriptionsSupported) return; // No-op for unsupported platforms
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
