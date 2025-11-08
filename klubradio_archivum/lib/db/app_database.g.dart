// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _podcastIdMeta = const VerificationMeta(
    'podcastId',
  );
  @override
  late final GeneratedColumn<String> podcastId = GeneratedColumn<String>(
    'podcast_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _subscribedAtMeta = const VerificationMeta(
    'subscribedAt',
  );
  @override
  late final GeneratedColumn<DateTime> subscribedAt = GeneratedColumn<DateTime>(
    'subscribed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _autoDownloadNMeta = const VerificationMeta(
    'autoDownloadN',
  );
  @override
  late final GeneratedColumn<int> autoDownloadN = GeneratedColumn<int>(
    'auto_download_n',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastHeardEpisodeIdMeta =
      const VerificationMeta('lastHeardEpisodeId');
  @override
  late final GeneratedColumn<String> lastHeardEpisodeId =
      GeneratedColumn<String>(
        'last_heard_episode_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastDownloadedEpisodeIdMeta =
      const VerificationMeta('lastDownloadedEpisodeId');
  @override
  late final GeneratedColumn<String> lastDownloadedEpisodeId =
      GeneratedColumn<String>(
        'last_downloaded_episode_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    podcastId,
    active,
    updatedAt,
    subscribedAt,
    autoDownloadN,
    lastHeardEpisodeId,
    lastDownloadedEpisodeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('podcast_id')) {
      context.handle(
        _podcastIdMeta,
        podcastId.isAcceptableOrUnknown(data['podcast_id']!, _podcastIdMeta),
      );
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('subscribed_at')) {
      context.handle(
        _subscribedAtMeta,
        subscribedAt.isAcceptableOrUnknown(
          data['subscribed_at']!,
          _subscribedAtMeta,
        ),
      );
    }
    if (data.containsKey('auto_download_n')) {
      context.handle(
        _autoDownloadNMeta,
        autoDownloadN.isAcceptableOrUnknown(
          data['auto_download_n']!,
          _autoDownloadNMeta,
        ),
      );
    }
    if (data.containsKey('last_heard_episode_id')) {
      context.handle(
        _lastHeardEpisodeIdMeta,
        lastHeardEpisodeId.isAcceptableOrUnknown(
          data['last_heard_episode_id']!,
          _lastHeardEpisodeIdMeta,
        ),
      );
    }
    if (data.containsKey('last_downloaded_episode_id')) {
      context.handle(
        _lastDownloadedEpisodeIdMeta,
        lastDownloadedEpisodeId.isAcceptableOrUnknown(
          data['last_downloaded_episode_id']!,
          _lastDownloadedEpisodeIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {podcastId};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      podcastId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}podcast_id'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      subscribedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}subscribed_at'],
      )!,
      autoDownloadN: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_download_n'],
      ),
      lastHeardEpisodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_heard_episode_id'],
      ),
      lastDownloadedEpisodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_downloaded_episode_id'],
      ),
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final String podcastId;
  final bool active;
  final DateTime updatedAt;
  final DateTime subscribedAt;
  final int? autoDownloadN;
  final String? lastHeardEpisodeId;
  final String? lastDownloadedEpisodeId;
  const Subscription({
    required this.podcastId,
    required this.active,
    required this.updatedAt,
    required this.subscribedAt,
    this.autoDownloadN,
    this.lastHeardEpisodeId,
    this.lastDownloadedEpisodeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['podcast_id'] = Variable<String>(podcastId);
    map['active'] = Variable<bool>(active);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['subscribed_at'] = Variable<DateTime>(subscribedAt);
    if (!nullToAbsent || autoDownloadN != null) {
      map['auto_download_n'] = Variable<int>(autoDownloadN);
    }
    if (!nullToAbsent || lastHeardEpisodeId != null) {
      map['last_heard_episode_id'] = Variable<String>(lastHeardEpisodeId);
    }
    if (!nullToAbsent || lastDownloadedEpisodeId != null) {
      map['last_downloaded_episode_id'] = Variable<String>(
        lastDownloadedEpisodeId,
      );
    }
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      podcastId: Value(podcastId),
      active: Value(active),
      updatedAt: Value(updatedAt),
      subscribedAt: Value(subscribedAt),
      autoDownloadN: autoDownloadN == null && nullToAbsent
          ? const Value.absent()
          : Value(autoDownloadN),
      lastHeardEpisodeId: lastHeardEpisodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastHeardEpisodeId),
      lastDownloadedEpisodeId: lastDownloadedEpisodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDownloadedEpisodeId),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      podcastId: serializer.fromJson<String>(json['podcastId']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      subscribedAt: serializer.fromJson<DateTime>(json['subscribedAt']),
      autoDownloadN: serializer.fromJson<int?>(json['autoDownloadN']),
      lastHeardEpisodeId: serializer.fromJson<String?>(
        json['lastHeardEpisodeId'],
      ),
      lastDownloadedEpisodeId: serializer.fromJson<String?>(
        json['lastDownloadedEpisodeId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'podcastId': serializer.toJson<String>(podcastId),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'subscribedAt': serializer.toJson<DateTime>(subscribedAt),
      'autoDownloadN': serializer.toJson<int?>(autoDownloadN),
      'lastHeardEpisodeId': serializer.toJson<String?>(lastHeardEpisodeId),
      'lastDownloadedEpisodeId': serializer.toJson<String?>(
        lastDownloadedEpisodeId,
      ),
    };
  }

  Subscription copyWith({
    String? podcastId,
    bool? active,
    DateTime? updatedAt,
    DateTime? subscribedAt,
    Value<int?> autoDownloadN = const Value.absent(),
    Value<String?> lastHeardEpisodeId = const Value.absent(),
    Value<String?> lastDownloadedEpisodeId = const Value.absent(),
  }) => Subscription(
    podcastId: podcastId ?? this.podcastId,
    active: active ?? this.active,
    updatedAt: updatedAt ?? this.updatedAt,
    subscribedAt: subscribedAt ?? this.subscribedAt,
    autoDownloadN: autoDownloadN.present
        ? autoDownloadN.value
        : this.autoDownloadN,
    lastHeardEpisodeId: lastHeardEpisodeId.present
        ? lastHeardEpisodeId.value
        : this.lastHeardEpisodeId,
    lastDownloadedEpisodeId: lastDownloadedEpisodeId.present
        ? lastDownloadedEpisodeId.value
        : this.lastDownloadedEpisodeId,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      podcastId: data.podcastId.present ? data.podcastId.value : this.podcastId,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      subscribedAt: data.subscribedAt.present
          ? data.subscribedAt.value
          : this.subscribedAt,
      autoDownloadN: data.autoDownloadN.present
          ? data.autoDownloadN.value
          : this.autoDownloadN,
      lastHeardEpisodeId: data.lastHeardEpisodeId.present
          ? data.lastHeardEpisodeId.value
          : this.lastHeardEpisodeId,
      lastDownloadedEpisodeId: data.lastDownloadedEpisodeId.present
          ? data.lastDownloadedEpisodeId.value
          : this.lastDownloadedEpisodeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('podcastId: $podcastId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('subscribedAt: $subscribedAt, ')
          ..write('autoDownloadN: $autoDownloadN, ')
          ..write('lastHeardEpisodeId: $lastHeardEpisodeId, ')
          ..write('lastDownloadedEpisodeId: $lastDownloadedEpisodeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    podcastId,
    active,
    updatedAt,
    subscribedAt,
    autoDownloadN,
    lastHeardEpisodeId,
    lastDownloadedEpisodeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.podcastId == this.podcastId &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt &&
          other.subscribedAt == this.subscribedAt &&
          other.autoDownloadN == this.autoDownloadN &&
          other.lastHeardEpisodeId == this.lastHeardEpisodeId &&
          other.lastDownloadedEpisodeId == this.lastDownloadedEpisodeId);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<String> podcastId;
  final Value<bool> active;
  final Value<DateTime> updatedAt;
  final Value<DateTime> subscribedAt;
  final Value<int?> autoDownloadN;
  final Value<String?> lastHeardEpisodeId;
  final Value<String?> lastDownloadedEpisodeId;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.podcastId = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.subscribedAt = const Value.absent(),
    this.autoDownloadN = const Value.absent(),
    this.lastHeardEpisodeId = const Value.absent(),
    this.lastDownloadedEpisodeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String podcastId,
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.subscribedAt = const Value.absent(),
    this.autoDownloadN = const Value.absent(),
    this.lastHeardEpisodeId = const Value.absent(),
    this.lastDownloadedEpisodeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : podcastId = Value(podcastId);
  static Insertable<Subscription> custom({
    Expression<String>? podcastId,
    Expression<bool>? active,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? subscribedAt,
    Expression<int>? autoDownloadN,
    Expression<String>? lastHeardEpisodeId,
    Expression<String>? lastDownloadedEpisodeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (podcastId != null) 'podcast_id': podcastId,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (subscribedAt != null) 'subscribed_at': subscribedAt,
      if (autoDownloadN != null) 'auto_download_n': autoDownloadN,
      if (lastHeardEpisodeId != null)
        'last_heard_episode_id': lastHeardEpisodeId,
      if (lastDownloadedEpisodeId != null)
        'last_downloaded_episode_id': lastDownloadedEpisodeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<String>? podcastId,
    Value<bool>? active,
    Value<DateTime>? updatedAt,
    Value<DateTime>? subscribedAt,
    Value<int?>? autoDownloadN,
    Value<String?>? lastHeardEpisodeId,
    Value<String?>? lastDownloadedEpisodeId,
    Value<int>? rowid,
  }) {
    return SubscriptionsCompanion(
      podcastId: podcastId ?? this.podcastId,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
      subscribedAt: subscribedAt ?? this.subscribedAt,
      autoDownloadN: autoDownloadN ?? this.autoDownloadN,
      lastHeardEpisodeId: lastHeardEpisodeId ?? this.lastHeardEpisodeId,
      lastDownloadedEpisodeId:
          lastDownloadedEpisodeId ?? this.lastDownloadedEpisodeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (subscribedAt.present) {
      map['subscribed_at'] = Variable<DateTime>(subscribedAt.value);
    }
    if (autoDownloadN.present) {
      map['auto_download_n'] = Variable<int>(autoDownloadN.value);
    }
    if (lastHeardEpisodeId.present) {
      map['last_heard_episode_id'] = Variable<String>(lastHeardEpisodeId.value);
    }
    if (lastDownloadedEpisodeId.present) {
      map['last_downloaded_episode_id'] = Variable<String>(
        lastDownloadedEpisodeId.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('podcastId: $podcastId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('subscribedAt: $subscribedAt, ')
          ..write('autoDownloadN: $autoDownloadN, ')
          ..write('lastHeardEpisodeId: $lastHeardEpisodeId, ')
          ..write('lastDownloadedEpisodeId: $lastDownloadedEpisodeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EpisodesTable extends Episodes with TableInfo<$EpisodesTable, Episode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpisodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _podcastIdMeta = const VerificationMeta(
    'podcastId',
  );
  @override
  late final GeneratedColumn<String> podcastId = GeneratedColumn<String>(
    'podcast_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bytesDownloadedMeta = const VerificationMeta(
    'bytesDownloaded',
  );
  @override
  late final GeneratedColumn<int> bytesDownloaded = GeneratedColumn<int>(
    'bytes_downloaded',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _cachedTitleMeta = const VerificationMeta(
    'cachedTitle',
  );
  @override
  late final GeneratedColumn<String> cachedTitle = GeneratedColumn<String>(
    'cached_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedImagePathMeta = const VerificationMeta(
    'cachedImagePath',
  );
  @override
  late final GeneratedColumn<String> cachedImagePath = GeneratedColumn<String>(
    'cached_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedMetaPathMeta = const VerificationMeta(
    'cachedMetaPath',
  );
  @override
  late final GeneratedColumn<String> cachedMetaPath = GeneratedColumn<String>(
    'cached_meta_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resumableMeta = const VerificationMeta(
    'resumable',
  );
  @override
  late final GeneratedColumn<bool> resumable = GeneratedColumn<bool>(
    'resumable',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("resumable" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    podcastId,
    title,
    audioUrl,
    publishedAt,
    status,
    progress,
    localPath,
    bytesDownloaded,
    totalBytes,
    playedAt,
    completedAt,
    createdAt,
    updatedAt,
    cachedTitle,
    cachedImagePath,
    cachedMetaPath,
    resumable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'episodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Episode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('podcast_id')) {
      context.handle(
        _podcastIdMeta,
        podcastId.isAcceptableOrUnknown(data['podcast_id']!, _podcastIdMeta),
      );
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_audioUrlMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('bytes_downloaded')) {
      context.handle(
        _bytesDownloadedMeta,
        bytesDownloaded.isAcceptableOrUnknown(
          data['bytes_downloaded']!,
          _bytesDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('cached_title')) {
      context.handle(
        _cachedTitleMeta,
        cachedTitle.isAcceptableOrUnknown(
          data['cached_title']!,
          _cachedTitleMeta,
        ),
      );
    }
    if (data.containsKey('cached_image_path')) {
      context.handle(
        _cachedImagePathMeta,
        cachedImagePath.isAcceptableOrUnknown(
          data['cached_image_path']!,
          _cachedImagePathMeta,
        ),
      );
    }
    if (data.containsKey('cached_meta_path')) {
      context.handle(
        _cachedMetaPathMeta,
        cachedMetaPath.isAcceptableOrUnknown(
          data['cached_meta_path']!,
          _cachedMetaPathMeta,
        ),
      );
    }
    if (data.containsKey('resumable')) {
      context.handle(
        _resumableMeta,
        resumable.isAcceptableOrUnknown(data['resumable']!, _resumableMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Episode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Episode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      podcastId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}podcast_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      bytesDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes_downloaded'],
      ),
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      ),
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_title'],
      ),
      cachedImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_image_path'],
      ),
      cachedMetaPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_meta_path'],
      ),
      resumable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}resumable'],
      ),
    );
  }

  @override
  $EpisodesTable createAlias(String alias) {
    return $EpisodesTable(attachedDatabase, alias);
  }
}

class Episode extends DataClass implements Insertable<Episode> {
  final String id;
  final String podcastId;
  final String title;
  final String audioUrl;
  final DateTime? publishedAt;

  /// Download-Status:
  /// 0=none, 1=queued, 2=downloading, 3=completed, 4=failed, 5=canceled
  final int status;
  final double progress;
  final String? localPath;
  final int? bytesDownloaded;
  final int? totalBytes;

  /// Nutzung/Retention
  final DateTime? playedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? cachedTitle;
  final String? cachedImagePath;
  final String? cachedMetaPath;
  final bool? resumable;
  const Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.audioUrl,
    this.publishedAt,
    required this.status,
    required this.progress,
    this.localPath,
    this.bytesDownloaded,
    this.totalBytes,
    this.playedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.cachedTitle,
    this.cachedImagePath,
    this.cachedMetaPath,
    this.resumable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['podcast_id'] = Variable<String>(podcastId);
    map['title'] = Variable<String>(title);
    map['audio_url'] = Variable<String>(audioUrl);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['status'] = Variable<int>(status);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || bytesDownloaded != null) {
      map['bytes_downloaded'] = Variable<int>(bytesDownloaded);
    }
    if (!nullToAbsent || totalBytes != null) {
      map['total_bytes'] = Variable<int>(totalBytes);
    }
    if (!nullToAbsent || playedAt != null) {
      map['played_at'] = Variable<DateTime>(playedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || cachedTitle != null) {
      map['cached_title'] = Variable<String>(cachedTitle);
    }
    if (!nullToAbsent || cachedImagePath != null) {
      map['cached_image_path'] = Variable<String>(cachedImagePath);
    }
    if (!nullToAbsent || cachedMetaPath != null) {
      map['cached_meta_path'] = Variable<String>(cachedMetaPath);
    }
    if (!nullToAbsent || resumable != null) {
      map['resumable'] = Variable<bool>(resumable);
    }
    return map;
  }

  EpisodesCompanion toCompanion(bool nullToAbsent) {
    return EpisodesCompanion(
      id: Value(id),
      podcastId: Value(podcastId),
      title: Value(title),
      audioUrl: Value(audioUrl),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      status: Value(status),
      progress: Value(progress),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      bytesDownloaded: bytesDownloaded == null && nullToAbsent
          ? const Value.absent()
          : Value(bytesDownloaded),
      totalBytes: totalBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBytes),
      playedAt: playedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(playedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedTitle: cachedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedTitle),
      cachedImagePath: cachedImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedImagePath),
      cachedMetaPath: cachedMetaPath == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedMetaPath),
      resumable: resumable == null && nullToAbsent
          ? const Value.absent()
          : Value(resumable),
    );
  }

  factory Episode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Episode(
      id: serializer.fromJson<String>(json['id']),
      podcastId: serializer.fromJson<String>(json['podcastId']),
      title: serializer.fromJson<String>(json['title']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      status: serializer.fromJson<int>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      bytesDownloaded: serializer.fromJson<int?>(json['bytesDownloaded']),
      totalBytes: serializer.fromJson<int?>(json['totalBytes']),
      playedAt: serializer.fromJson<DateTime?>(json['playedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cachedTitle: serializer.fromJson<String?>(json['cachedTitle']),
      cachedImagePath: serializer.fromJson<String?>(json['cachedImagePath']),
      cachedMetaPath: serializer.fromJson<String?>(json['cachedMetaPath']),
      resumable: serializer.fromJson<bool?>(json['resumable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'podcastId': serializer.toJson<String>(podcastId),
      'title': serializer.toJson<String>(title),
      'audioUrl': serializer.toJson<String>(audioUrl),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'status': serializer.toJson<int>(status),
      'progress': serializer.toJson<double>(progress),
      'localPath': serializer.toJson<String?>(localPath),
      'bytesDownloaded': serializer.toJson<int?>(bytesDownloaded),
      'totalBytes': serializer.toJson<int?>(totalBytes),
      'playedAt': serializer.toJson<DateTime?>(playedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cachedTitle': serializer.toJson<String?>(cachedTitle),
      'cachedImagePath': serializer.toJson<String?>(cachedImagePath),
      'cachedMetaPath': serializer.toJson<String?>(cachedMetaPath),
      'resumable': serializer.toJson<bool?>(resumable),
    };
  }

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? audioUrl,
    Value<DateTime?> publishedAt = const Value.absent(),
    int? status,
    double? progress,
    Value<String?> localPath = const Value.absent(),
    Value<int?> bytesDownloaded = const Value.absent(),
    Value<int?> totalBytes = const Value.absent(),
    Value<DateTime?> playedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> cachedTitle = const Value.absent(),
    Value<String?> cachedImagePath = const Value.absent(),
    Value<String?> cachedMetaPath = const Value.absent(),
    Value<bool?> resumable = const Value.absent(),
  }) => Episode(
    id: id ?? this.id,
    podcastId: podcastId ?? this.podcastId,
    title: title ?? this.title,
    audioUrl: audioUrl ?? this.audioUrl,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    localPath: localPath.present ? localPath.value : this.localPath,
    bytesDownloaded: bytesDownloaded.present
        ? bytesDownloaded.value
        : this.bytesDownloaded,
    totalBytes: totalBytes.present ? totalBytes.value : this.totalBytes,
    playedAt: playedAt.present ? playedAt.value : this.playedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedTitle: cachedTitle.present ? cachedTitle.value : this.cachedTitle,
    cachedImagePath: cachedImagePath.present
        ? cachedImagePath.value
        : this.cachedImagePath,
    cachedMetaPath: cachedMetaPath.present
        ? cachedMetaPath.value
        : this.cachedMetaPath,
    resumable: resumable.present ? resumable.value : this.resumable,
  );
  Episode copyWithCompanion(EpisodesCompanion data) {
    return Episode(
      id: data.id.present ? data.id.value : this.id,
      podcastId: data.podcastId.present ? data.podcastId.value : this.podcastId,
      title: data.title.present ? data.title.value : this.title,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      bytesDownloaded: data.bytesDownloaded.present
          ? data.bytesDownloaded.value
          : this.bytesDownloaded,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedTitle: data.cachedTitle.present
          ? data.cachedTitle.value
          : this.cachedTitle,
      cachedImagePath: data.cachedImagePath.present
          ? data.cachedImagePath.value
          : this.cachedImagePath,
      cachedMetaPath: data.cachedMetaPath.present
          ? data.cachedMetaPath.value
          : this.cachedMetaPath,
      resumable: data.resumable.present ? data.resumable.value : this.resumable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Episode(')
          ..write('id: $id, ')
          ..write('podcastId: $podcastId, ')
          ..write('title: $title, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('localPath: $localPath, ')
          ..write('bytesDownloaded: $bytesDownloaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('playedAt: $playedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedImagePath: $cachedImagePath, ')
          ..write('cachedMetaPath: $cachedMetaPath, ')
          ..write('resumable: $resumable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    podcastId,
    title,
    audioUrl,
    publishedAt,
    status,
    progress,
    localPath,
    bytesDownloaded,
    totalBytes,
    playedAt,
    completedAt,
    createdAt,
    updatedAt,
    cachedTitle,
    cachedImagePath,
    cachedMetaPath,
    resumable,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Episode &&
          other.id == this.id &&
          other.podcastId == this.podcastId &&
          other.title == this.title &&
          other.audioUrl == this.audioUrl &&
          other.publishedAt == this.publishedAt &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.localPath == this.localPath &&
          other.bytesDownloaded == this.bytesDownloaded &&
          other.totalBytes == this.totalBytes &&
          other.playedAt == this.playedAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedTitle == this.cachedTitle &&
          other.cachedImagePath == this.cachedImagePath &&
          other.cachedMetaPath == this.cachedMetaPath &&
          other.resumable == this.resumable);
}

class EpisodesCompanion extends UpdateCompanion<Episode> {
  final Value<String> id;
  final Value<String> podcastId;
  final Value<String> title;
  final Value<String> audioUrl;
  final Value<DateTime?> publishedAt;
  final Value<int> status;
  final Value<double> progress;
  final Value<String?> localPath;
  final Value<int?> bytesDownloaded;
  final Value<int?> totalBytes;
  final Value<DateTime?> playedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> cachedTitle;
  final Value<String?> cachedImagePath;
  final Value<String?> cachedMetaPath;
  final Value<bool?> resumable;
  final Value<int> rowid;
  const EpisodesCompanion({
    this.id = const Value.absent(),
    this.podcastId = const Value.absent(),
    this.title = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.localPath = const Value.absent(),
    this.bytesDownloaded = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedTitle = const Value.absent(),
    this.cachedImagePath = const Value.absent(),
    this.cachedMetaPath = const Value.absent(),
    this.resumable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EpisodesCompanion.insert({
    required String id,
    required String podcastId,
    required String title,
    required String audioUrl,
    this.publishedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.localPath = const Value.absent(),
    this.bytesDownloaded = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedTitle = const Value.absent(),
    this.cachedImagePath = const Value.absent(),
    this.cachedMetaPath = const Value.absent(),
    this.resumable = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       podcastId = Value(podcastId),
       title = Value(title),
       audioUrl = Value(audioUrl);
  static Insertable<Episode> custom({
    Expression<String>? id,
    Expression<String>? podcastId,
    Expression<String>? title,
    Expression<String>? audioUrl,
    Expression<DateTime>? publishedAt,
    Expression<int>? status,
    Expression<double>? progress,
    Expression<String>? localPath,
    Expression<int>? bytesDownloaded,
    Expression<int>? totalBytes,
    Expression<DateTime>? playedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? cachedTitle,
    Expression<String>? cachedImagePath,
    Expression<String>? cachedMetaPath,
    Expression<bool>? resumable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (podcastId != null) 'podcast_id': podcastId,
      if (title != null) 'title': title,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (publishedAt != null) 'published_at': publishedAt,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (localPath != null) 'local_path': localPath,
      if (bytesDownloaded != null) 'bytes_downloaded': bytesDownloaded,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (playedAt != null) 'played_at': playedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedTitle != null) 'cached_title': cachedTitle,
      if (cachedImagePath != null) 'cached_image_path': cachedImagePath,
      if (cachedMetaPath != null) 'cached_meta_path': cachedMetaPath,
      if (resumable != null) 'resumable': resumable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EpisodesCompanion copyWith({
    Value<String>? id,
    Value<String>? podcastId,
    Value<String>? title,
    Value<String>? audioUrl,
    Value<DateTime?>? publishedAt,
    Value<int>? status,
    Value<double>? progress,
    Value<String?>? localPath,
    Value<int?>? bytesDownloaded,
    Value<int?>? totalBytes,
    Value<DateTime?>? playedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? cachedTitle,
    Value<String?>? cachedImagePath,
    Value<String?>? cachedMetaPath,
    Value<bool?>? resumable,
    Value<int>? rowid,
  }) {
    return EpisodesCompanion(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      audioUrl: audioUrl ?? this.audioUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      localPath: localPath ?? this.localPath,
      bytesDownloaded: bytesDownloaded ?? this.bytesDownloaded,
      totalBytes: totalBytes ?? this.totalBytes,
      playedAt: playedAt ?? this.playedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedTitle: cachedTitle ?? this.cachedTitle,
      cachedImagePath: cachedImagePath ?? this.cachedImagePath,
      cachedMetaPath: cachedMetaPath ?? this.cachedMetaPath,
      resumable: resumable ?? this.resumable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (bytesDownloaded.present) {
      map['bytes_downloaded'] = Variable<int>(bytesDownloaded.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedTitle.present) {
      map['cached_title'] = Variable<String>(cachedTitle.value);
    }
    if (cachedImagePath.present) {
      map['cached_image_path'] = Variable<String>(cachedImagePath.value);
    }
    if (cachedMetaPath.present) {
      map['cached_meta_path'] = Variable<String>(cachedMetaPath.value);
    }
    if (resumable.present) {
      map['resumable'] = Variable<bool>(resumable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpisodesCompanion(')
          ..write('id: $id, ')
          ..write('podcastId: $podcastId, ')
          ..write('title: $title, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('localPath: $localPath, ')
          ..write('bytesDownloaded: $bytesDownloaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('playedAt: $playedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedImagePath: $cachedImagePath, ')
          ..write('cachedMetaPath: $cachedMetaPath, ')
          ..write('resumable: $resumable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wifiOnlyMeta = const VerificationMeta(
    'wifiOnly',
  );
  @override
  late final GeneratedColumn<bool> wifiOnly = GeneratedColumn<bool>(
    'wifi_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("wifi_only" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _maxParallelMeta = const VerificationMeta(
    'maxParallel',
  );
  @override
  late final GeneratedColumn<int> maxParallel = GeneratedColumn<int>(
    'max_parallel',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _deleteAfterHoursMeta = const VerificationMeta(
    'deleteAfterHours',
  );
  @override
  late final GeneratedColumn<int> deleteAfterHours = GeneratedColumn<int>(
    'delete_after_hours',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keepLatestNMeta = const VerificationMeta(
    'keepLatestN',
  );
  @override
  late final GeneratedColumn<int> keepLatestN = GeneratedColumn<int>(
    'keep_latest_n',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autodownloadSubscribedMeta =
      const VerificationMeta('autodownloadSubscribed');
  @override
  late final GeneratedColumn<bool> autodownloadSubscribed =
      GeneratedColumn<bool>(
        'autodownload_subscribed',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("autodownload_subscribed" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wifiOnly,
    maxParallel,
    deleteAfterHours,
    keepLatestN,
    autodownloadSubscribed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wifi_only')) {
      context.handle(
        _wifiOnlyMeta,
        wifiOnly.isAcceptableOrUnknown(data['wifi_only']!, _wifiOnlyMeta),
      );
    }
    if (data.containsKey('max_parallel')) {
      context.handle(
        _maxParallelMeta,
        maxParallel.isAcceptableOrUnknown(
          data['max_parallel']!,
          _maxParallelMeta,
        ),
      );
    }
    if (data.containsKey('delete_after_hours')) {
      context.handle(
        _deleteAfterHoursMeta,
        deleteAfterHours.isAcceptableOrUnknown(
          data['delete_after_hours']!,
          _deleteAfterHoursMeta,
        ),
      );
    }
    if (data.containsKey('keep_latest_n')) {
      context.handle(
        _keepLatestNMeta,
        keepLatestN.isAcceptableOrUnknown(
          data['keep_latest_n']!,
          _keepLatestNMeta,
        ),
      );
    }
    if (data.containsKey('autodownload_subscribed')) {
      context.handle(
        _autodownloadSubscribedMeta,
        autodownloadSubscribed.isAcceptableOrUnknown(
          data['autodownload_subscribed']!,
          _autodownloadSubscribedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wifiOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}wifi_only'],
      )!,
      maxParallel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_parallel'],
      )!,
      deleteAfterHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delete_after_hours'],
      ),
      keepLatestN: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}keep_latest_n'],
      ),
      autodownloadSubscribed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}autodownload_subscribed'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final bool wifiOnly;
  final int maxParallel;
  final int? deleteAfterHours;
  final int? keepLatestN;
  final bool autodownloadSubscribed;
  const Setting({
    required this.id,
    required this.wifiOnly,
    required this.maxParallel,
    this.deleteAfterHours,
    this.keepLatestN,
    required this.autodownloadSubscribed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wifi_only'] = Variable<bool>(wifiOnly);
    map['max_parallel'] = Variable<int>(maxParallel);
    if (!nullToAbsent || deleteAfterHours != null) {
      map['delete_after_hours'] = Variable<int>(deleteAfterHours);
    }
    if (!nullToAbsent || keepLatestN != null) {
      map['keep_latest_n'] = Variable<int>(keepLatestN);
    }
    map['autodownload_subscribed'] = Variable<bool>(autodownloadSubscribed);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      wifiOnly: Value(wifiOnly),
      maxParallel: Value(maxParallel),
      deleteAfterHours: deleteAfterHours == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteAfterHours),
      keepLatestN: keepLatestN == null && nullToAbsent
          ? const Value.absent()
          : Value(keepLatestN),
      autodownloadSubscribed: Value(autodownloadSubscribed),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      wifiOnly: serializer.fromJson<bool>(json['wifiOnly']),
      maxParallel: serializer.fromJson<int>(json['maxParallel']),
      deleteAfterHours: serializer.fromJson<int?>(json['deleteAfterHours']),
      keepLatestN: serializer.fromJson<int?>(json['keepLatestN']),
      autodownloadSubscribed: serializer.fromJson<bool>(
        json['autodownloadSubscribed'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wifiOnly': serializer.toJson<bool>(wifiOnly),
      'maxParallel': serializer.toJson<int>(maxParallel),
      'deleteAfterHours': serializer.toJson<int?>(deleteAfterHours),
      'keepLatestN': serializer.toJson<int?>(keepLatestN),
      'autodownloadSubscribed': serializer.toJson<bool>(autodownloadSubscribed),
    };
  }

  Setting copyWith({
    int? id,
    bool? wifiOnly,
    int? maxParallel,
    Value<int?> deleteAfterHours = const Value.absent(),
    Value<int?> keepLatestN = const Value.absent(),
    bool? autodownloadSubscribed,
  }) => Setting(
    id: id ?? this.id,
    wifiOnly: wifiOnly ?? this.wifiOnly,
    maxParallel: maxParallel ?? this.maxParallel,
    deleteAfterHours: deleteAfterHours.present
        ? deleteAfterHours.value
        : this.deleteAfterHours,
    keepLatestN: keepLatestN.present ? keepLatestN.value : this.keepLatestN,
    autodownloadSubscribed:
        autodownloadSubscribed ?? this.autodownloadSubscribed,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      wifiOnly: data.wifiOnly.present ? data.wifiOnly.value : this.wifiOnly,
      maxParallel: data.maxParallel.present
          ? data.maxParallel.value
          : this.maxParallel,
      deleteAfterHours: data.deleteAfterHours.present
          ? data.deleteAfterHours.value
          : this.deleteAfterHours,
      keepLatestN: data.keepLatestN.present
          ? data.keepLatestN.value
          : this.keepLatestN,
      autodownloadSubscribed: data.autodownloadSubscribed.present
          ? data.autodownloadSubscribed.value
          : this.autodownloadSubscribed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('wifiOnly: $wifiOnly, ')
          ..write('maxParallel: $maxParallel, ')
          ..write('deleteAfterHours: $deleteAfterHours, ')
          ..write('keepLatestN: $keepLatestN, ')
          ..write('autodownloadSubscribed: $autodownloadSubscribed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wifiOnly,
    maxParallel,
    deleteAfterHours,
    keepLatestN,
    autodownloadSubscribed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.wifiOnly == this.wifiOnly &&
          other.maxParallel == this.maxParallel &&
          other.deleteAfterHours == this.deleteAfterHours &&
          other.keepLatestN == this.keepLatestN &&
          other.autodownloadSubscribed == this.autodownloadSubscribed);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<bool> wifiOnly;
  final Value<int> maxParallel;
  final Value<int?> deleteAfterHours;
  final Value<int?> keepLatestN;
  final Value<bool> autodownloadSubscribed;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.wifiOnly = const Value.absent(),
    this.maxParallel = const Value.absent(),
    this.deleteAfterHours = const Value.absent(),
    this.keepLatestN = const Value.absent(),
    this.autodownloadSubscribed = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.wifiOnly = const Value.absent(),
    this.maxParallel = const Value.absent(),
    this.deleteAfterHours = const Value.absent(),
    this.keepLatestN = const Value.absent(),
    this.autodownloadSubscribed = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<bool>? wifiOnly,
    Expression<int>? maxParallel,
    Expression<int>? deleteAfterHours,
    Expression<int>? keepLatestN,
    Expression<bool>? autodownloadSubscribed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wifiOnly != null) 'wifi_only': wifiOnly,
      if (maxParallel != null) 'max_parallel': maxParallel,
      if (deleteAfterHours != null) 'delete_after_hours': deleteAfterHours,
      if (keepLatestN != null) 'keep_latest_n': keepLatestN,
      if (autodownloadSubscribed != null)
        'autodownload_subscribed': autodownloadSubscribed,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? wifiOnly,
    Value<int>? maxParallel,
    Value<int?>? deleteAfterHours,
    Value<int?>? keepLatestN,
    Value<bool>? autodownloadSubscribed,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      maxParallel: maxParallel ?? this.maxParallel,
      deleteAfterHours: deleteAfterHours ?? this.deleteAfterHours,
      keepLatestN: keepLatestN ?? this.keepLatestN,
      autodownloadSubscribed:
          autodownloadSubscribed ?? this.autodownloadSubscribed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wifiOnly.present) {
      map['wifi_only'] = Variable<bool>(wifiOnly.value);
    }
    if (maxParallel.present) {
      map['max_parallel'] = Variable<int>(maxParallel.value);
    }
    if (deleteAfterHours.present) {
      map['delete_after_hours'] = Variable<int>(deleteAfterHours.value);
    }
    if (keepLatestN.present) {
      map['keep_latest_n'] = Variable<int>(keepLatestN.value);
    }
    if (autodownloadSubscribed.present) {
      map['autodownload_subscribed'] = Variable<bool>(
        autodownloadSubscribed.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('wifiOnly: $wifiOnly, ')
          ..write('maxParallel: $maxParallel, ')
          ..write('deleteAfterHours: $deleteAfterHours, ')
          ..write('keepLatestN: $keepLatestN, ')
          ..write('autodownloadSubscribed: $autodownloadSubscribed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $EpisodesTable episodes = $EpisodesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    subscriptions,
    episodes,
    settings,
  ];
}

typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      required String podcastId,
      Value<bool> active,
      Value<DateTime> updatedAt,
      Value<DateTime> subscribedAt,
      Value<int?> autoDownloadN,
      Value<String?> lastHeardEpisodeId,
      Value<String?> lastDownloadedEpisodeId,
      Value<int> rowid,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<String> podcastId,
      Value<bool> active,
      Value<DateTime> updatedAt,
      Value<DateTime> subscribedAt,
      Value<int?> autoDownloadN,
      Value<String?> lastHeardEpisodeId,
      Value<String?> lastDownloadedEpisodeId,
      Value<int> rowid,
    });

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get podcastId =>
      $composableBuilder(column: $table.podcastId, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => column,
  );
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (
            Subscription,
            BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
          ),
          Subscription,
          PrefetchHooks Function()
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> podcastId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> subscribedAt = const Value.absent(),
                Value<int?> autoDownloadN = const Value.absent(),
                Value<String?> lastHeardEpisodeId = const Value.absent(),
                Value<String?> lastDownloadedEpisodeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion(
                podcastId: podcastId,
                active: active,
                updatedAt: updatedAt,
                subscribedAt: subscribedAt,
                autoDownloadN: autoDownloadN,
                lastHeardEpisodeId: lastHeardEpisodeId,
                lastDownloadedEpisodeId: lastDownloadedEpisodeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String podcastId,
                Value<bool> active = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> subscribedAt = const Value.absent(),
                Value<int?> autoDownloadN = const Value.absent(),
                Value<String?> lastHeardEpisodeId = const Value.absent(),
                Value<String?> lastDownloadedEpisodeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                podcastId: podcastId,
                active: active,
                updatedAt: updatedAt,
                subscribedAt: subscribedAt,
                autoDownloadN: autoDownloadN,
                lastHeardEpisodeId: lastHeardEpisodeId,
                lastDownloadedEpisodeId: lastDownloadedEpisodeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (
        Subscription,
        BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
      ),
      Subscription,
      PrefetchHooks Function()
    >;
typedef $$EpisodesTableCreateCompanionBuilder =
    EpisodesCompanion Function({
      required String id,
      required String podcastId,
      required String title,
      required String audioUrl,
      Value<DateTime?> publishedAt,
      Value<int> status,
      Value<double> progress,
      Value<String?> localPath,
      Value<int?> bytesDownloaded,
      Value<int?> totalBytes,
      Value<DateTime?> playedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> cachedTitle,
      Value<String?> cachedImagePath,
      Value<String?> cachedMetaPath,
      Value<bool?> resumable,
      Value<int> rowid,
    });
typedef $$EpisodesTableUpdateCompanionBuilder =
    EpisodesCompanion Function({
      Value<String> id,
      Value<String> podcastId,
      Value<String> title,
      Value<String> audioUrl,
      Value<DateTime?> publishedAt,
      Value<int> status,
      Value<double> progress,
      Value<String?> localPath,
      Value<int?> bytesDownloaded,
      Value<int?> totalBytes,
      Value<DateTime?> playedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> cachedTitle,
      Value<String?> cachedImagePath,
      Value<String?> cachedMetaPath,
      Value<bool?> resumable,
      Value<int> rowid,
    });

class $$EpisodesTableFilterComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get resumable => $composableBuilder(
    column: $table.resumable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EpisodesTableOrderingComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get resumable => $composableBuilder(
    column: $table.resumable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EpisodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get podcastId =>
      $composableBuilder(column: $table.podcastId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get resumable =>
      $composableBuilder(column: $table.resumable, builder: (column) => column);
}

class $$EpisodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EpisodesTable,
          Episode,
          $$EpisodesTableFilterComposer,
          $$EpisodesTableOrderingComposer,
          $$EpisodesTableAnnotationComposer,
          $$EpisodesTableCreateCompanionBuilder,
          $$EpisodesTableUpdateCompanionBuilder,
          (Episode, BaseReferences<_$AppDatabase, $EpisodesTable, Episode>),
          Episode,
          PrefetchHooks Function()
        > {
  $$EpisodesTableTableManager(_$AppDatabase db, $EpisodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EpisodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EpisodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EpisodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> podcastId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> bytesDownloaded = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<DateTime?> playedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> cachedTitle = const Value.absent(),
                Value<String?> cachedImagePath = const Value.absent(),
                Value<String?> cachedMetaPath = const Value.absent(),
                Value<bool?> resumable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpisodesCompanion(
                id: id,
                podcastId: podcastId,
                title: title,
                audioUrl: audioUrl,
                publishedAt: publishedAt,
                status: status,
                progress: progress,
                localPath: localPath,
                bytesDownloaded: bytesDownloaded,
                totalBytes: totalBytes,
                playedAt: playedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedTitle: cachedTitle,
                cachedImagePath: cachedImagePath,
                cachedMetaPath: cachedMetaPath,
                resumable: resumable,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String podcastId,
                required String title,
                required String audioUrl,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> bytesDownloaded = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<DateTime?> playedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> cachedTitle = const Value.absent(),
                Value<String?> cachedImagePath = const Value.absent(),
                Value<String?> cachedMetaPath = const Value.absent(),
                Value<bool?> resumable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpisodesCompanion.insert(
                id: id,
                podcastId: podcastId,
                title: title,
                audioUrl: audioUrl,
                publishedAt: publishedAt,
                status: status,
                progress: progress,
                localPath: localPath,
                bytesDownloaded: bytesDownloaded,
                totalBytes: totalBytes,
                playedAt: playedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedTitle: cachedTitle,
                cachedImagePath: cachedImagePath,
                cachedMetaPath: cachedMetaPath,
                resumable: resumable,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EpisodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EpisodesTable,
      Episode,
      $$EpisodesTableFilterComposer,
      $$EpisodesTableOrderingComposer,
      $$EpisodesTableAnnotationComposer,
      $$EpisodesTableCreateCompanionBuilder,
      $$EpisodesTableUpdateCompanionBuilder,
      (Episode, BaseReferences<_$AppDatabase, $EpisodesTable, Episode>),
      Episode,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> wifiOnly,
      Value<int> maxParallel,
      Value<int?> deleteAfterHours,
      Value<int?> keepLatestN,
      Value<bool> autodownloadSubscribed,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> wifiOnly,
      Value<int> maxParallel,
      Value<int?> deleteAfterHours,
      Value<int?> keepLatestN,
      Value<bool> autodownloadSubscribed,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wifiOnly => $composableBuilder(
    column: $table.wifiOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wifiOnly => $composableBuilder(
    column: $table.wifiOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get wifiOnly =>
      $composableBuilder(column: $table.wifiOnly, builder: (column) => column);

  GeneratedColumn<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> wifiOnly = const Value.absent(),
                Value<int> maxParallel = const Value.absent(),
                Value<int?> deleteAfterHours = const Value.absent(),
                Value<int?> keepLatestN = const Value.absent(),
                Value<bool> autodownloadSubscribed = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                wifiOnly: wifiOnly,
                maxParallel: maxParallel,
                deleteAfterHours: deleteAfterHours,
                keepLatestN: keepLatestN,
                autodownloadSubscribed: autodownloadSubscribed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> wifiOnly = const Value.absent(),
                Value<int> maxParallel = const Value.absent(),
                Value<int?> deleteAfterHours = const Value.absent(),
                Value<int?> keepLatestN = const Value.absent(),
                Value<bool> autodownloadSubscribed = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                wifiOnly: wifiOnly,
                maxParallel: maxParallel,
                deleteAfterHours: deleteAfterHours,
                keepLatestN: keepLatestN,
                autodownloadSubscribed: autodownloadSubscribed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db, _db.episodes);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
