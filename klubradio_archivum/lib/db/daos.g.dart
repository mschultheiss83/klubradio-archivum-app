// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$SubscriptionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
  SubscriptionsDaoManager get managers => SubscriptionsDaoManager(this);
}

class SubscriptionsDaoManager {
  final _$SubscriptionsDaoMixin _db;
  SubscriptionsDaoManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db.attachedDatabase, _db.subscriptions);
}

mixin _$EpisodesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
  EpisodesDaoManager get managers => EpisodesDaoManager(this);
}

class EpisodesDaoManager {
  final _$EpisodesDaoMixin _db;
  EpisodesDaoManager(this._db);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db.attachedDatabase, _db.episodes);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db.attachedDatabase, _db.subscriptions);
}

mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SettingsTable get settings => attachedDatabase.settings;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db.attachedDatabase, _db.settings);
}
