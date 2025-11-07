// lib/providers/subscription_provider.dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({required this.subscriptionsDao});

  final SubscriptionsDao subscriptionsDao;

  bool _busy = false;
  bool get busy => _busy;

  Stream<Subscription?> watchSubscription(String podcastId) {
    return subscriptionsDao.watchOne(podcastId);
  }

  Future<void> toggleSubscription(String podcastId, bool isSubscribed) async {
    _busy = true;
    notifyListeners();
    try {
      await subscriptionsDao.toggleSubscribe(
        podcastId: podcastId,
        active: !isSubscribed,
      );
    } finally {
      _busy = false;
      notifyListeners();
    }
  }
}
