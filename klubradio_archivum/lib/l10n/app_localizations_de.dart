// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Klubrádió Archiv';

  @override
  String get downloadListTitle => 'Downloads';

  @override
  String get downloadStatusQueued => 'In Warteschlange';

  @override
  String get downloadStatusNotDownloaded => 'Nicht heruntergeladen';

  @override
  String get downloadStatusDownloaded => 'Heruntergeladen';

  @override
  String get downloadStatusDownloading => 'Wird heruntergeladen';

  @override
  String get downloadStatusFailed => 'Fehlgeschlagen';

  @override
  String get downloadActionRetry => 'Wiederholen';

  @override
  String get downloadActionCancel => 'Abbrechen';

  @override
  String get downloadActionDelete => 'Löschen';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Noch keine Downloads';

  @override
  String get aboutScreenAppBarTitle => 'Über die Anwendung';

  @override
  String get aboutScreenAppNameDetail => 'Klubrádió Archiv Anwendung';

  @override
  String get aboutScreenPurpose =>
      'Ziel der Anwendung ist es, einen einfachen Zugang zu den archivierten Sendungen von Klubrádió zu ermöglichen und die Erstellung von RSS-Feeds für Podcast-Player zu erlauben.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Dies ist ein Gemeinschaftsprojekt, das der Unterstützung von Klubrádió dient. Alle Inhalte sind auf der offiziellen Webseite des Radios frei verfügbar.';

  @override
  String get aboutScreenContactInfo =>
      'Kontakt: info@klubradio.hu (Inhalt), multilevelstudios@gmail.com (Entwicklerkontakt)';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get errorDialogTitle => 'Fehler';

  @override
  String get unexpectedError =>
      'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'Fehler aufgetreten: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Erfolgreich abonniert!';

  @override
  String get podcastDetailSubscribeButton => 'Abonnieren';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'Noch keine Abos – entdecke Podcasts und tippe auf „Abonnieren“.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Abonnierte Sendungen';

  @override
  String get homeScreenRecentEpisodesTitle => 'Neueste Episoden';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Zuletzt gehört';

  @override
  String get themeSettingSystemDefault => 'Systemstandard';

  @override
  String get themeSettingLight => 'Hell';

  @override
  String get themeSettingDark => 'Dunkel';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Klubrádió unterstützen';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Öffne die Support-Seite im Browser.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'App-Entwickler unterstützen';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Freiwillige Spende für weitere Entwicklungen.';

  @override
  String get themeSettingsSectionTitle => 'Design-Einstellungen';

  @override
  String get bottomNavHome => 'Startseite';

  @override
  String get bottomNavDiscover => 'Entdecken';

  @override
  String get bottomNavSearch => 'Suche';

  @override
  String get bottomNavDownloads => 'Downloads';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Einstellungen';

  @override
  String get playbackSettingsTitle => 'Wiedergabeeinstellungen';

  @override
  String get playbackSettingsSpeedLabel => 'Wiedergabegeschwindigkeit:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatische Downloads:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Folgen',
      one: '1 Folge',
      zero: 'Keine Folgen',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" ausgewählt.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Top-Sendungen';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Empfohlene Sendungen';

  @override
  String get discoverScreenTrendingTitle => 'Angesagt';

  @override
  String get discoverScreenNoTopShows =>
      'Keine vorgestellten Sendungen verfügbar.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Keine Empfehlungen verfügbar. Bitte aktualisiere die Daten später.';

  @override
  String get trendingPodcastsNoShows =>
      'Keine angesagten Sendungen auf der Liste.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Du hast noch keine Sendungen abonniert.';

  @override
  String get recentSearchesNoHistory => 'Noch kein Suchverlauf vorhanden.';

  @override
  String get searchBarHintText => 'Sendungen, Moderatoren, Schlüsselwörter...';

  @override
  String get searchResultsNoResults =>
      'Keine Ergebnisse für Ihre Suche gefunden.';

  @override
  String get searchScreenInitialPrompt =>
      'Finde deine Lieblingssendungen oder Moderatoren.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'Ein Fehler ist aufgetreten: $errorDetails';
  }

  @override
  String get errorParsingData =>
      'Bei der Verarbeitung der Daten ist ein Problem aufgetreten.';

  @override
  String get errorUnknown => 'Ein unbekannter Fehler ist aufgetreten.';

  @override
  String get profileScreenNoEmail => 'Keine E-Mail-Adresse angegeben';

  @override
  String get profileScreenDownloadSettingsTitle => 'Downloadeinstellungen';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatische Downloads';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Anzahl der Episoden: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Zuletzt abgespielte Episoden';

  @override
  String get profileScreenFavoritesTitle => 'Favoriten';

  @override
  String get profileScreenNoFavoriteEpisodes =>
      'Noch keine Favoriten vorhanden.';

  @override
  String get profileScreenGuestUserDisplayName => 'Gastbenutzer';

  @override
  String get aboutScreenLicenseTitle => 'Lizenz / Rechtliches';

  @override
  String get aboutScreenLicenseSummary =>
      'Lizenz- und rechtliche Hinweise öffnen.';

  @override
  String get aboutScreenVersionTitle => 'Version';

  @override
  String aboutScreenVersionFormat(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String podcastInfoCardHostsLabel(String hostNames) {
    return '$hostNames';
  }

  @override
  String podcastDetailScreenErrorMessage(String errorDetails) {
    return 'Fehler beim Laden der Episoden: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Abonnieren';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Deabonnieren';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Erfolgreich abonniert!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Erfolgreich abbestellt!';

  @override
  String get unsubscribeDialogTitle => 'Abbestellen';

  @override
  String get unsubscribeDialogContent =>
      'Möchten Sie die heruntergeladenen Episoden für diesen Podcast löschen?';

  @override
  String get unsubscribeDialogDeleteButton => 'Episoden löschen';

  @override
  String get unsubscribeDialogKeepButton => 'Episoden behalten';

  @override
  String get nowPlayingScreenTitle => 'Aktuelle Wiedergabe';

  @override
  String get nowPlayingScreenNoEpisode =>
      'Aktuell wird keine Episode abgespielt.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String durationInMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get podcastNotFoundError =>
      'Die ausgewählte Sendung konnte leider nicht gefunden werden.';

  @override
  String get podcastListItem_subscribed => 'Abonniert';

  @override
  String get podcastListItem_unsubscribe => 'Abo beenden';

  @override
  String get podcastListItem_subscribe => 'Abonnieren';

  @override
  String get podcastListItem_unsubscribed => 'Abo beendet';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió-Sendung';

  @override
  String get podcastListItem_openDetails => 'Podcastdetails öffnen';

  @override
  String get downloads_tab_active => 'Aktiv';

  @override
  String get downloads_tab_done => 'Fertig';

  @override
  String get downloads_empty_active => 'Keine aktiven Downloads';

  @override
  String get downloads_empty_done => 'Keine fertigen Downloads';

  @override
  String get downloads_status_waiting => 'Wartet';

  @override
  String get downloads_status_running => 'Lädt';

  @override
  String get downloads_status_done => 'Fertig';

  @override
  String get downloads_status_failed => 'Fehler';

  @override
  String get downloads_status_canceled => 'Abgebrochen';

  @override
  String get downloads_status_unknown => 'Unbekannt';

  @override
  String get downloads_action_pause => 'Pause';

  @override
  String get downloads_action_resume => 'Fortsetzen';

  @override
  String get downloads_action_cancel => 'Abbrechen';

  @override
  String get downloads_action_delete => 'Löschen';

  @override
  String get ep_action_resume => 'Fortsetzen';

  @override
  String get ep_action_downloaded => 'Heruntergeladen';

  @override
  String get ep_action_retry => 'Erneut versuchen';

  @override
  String get ep_action_download => 'Download';

  @override
  String get settings_title_downloads => 'Downloads';

  @override
  String get settings_wifi_only => 'Nur WLAN';

  @override
  String get settings_wifi_only_mobile_default => 'Standard auf Mobil: AN';

  @override
  String get settings_wifi_only_desktop_default => 'Standard auf Desktop: AUS';

  @override
  String get settings_max_parallel => 'Max. gleichzeitige Downloads';

  @override
  String get settings_retention_section => 'Aufbewahrung';

  @override
  String get settings_keep_all => 'Alle behalten';

  @override
  String get settings_keep_latest_label => 'Nur die letzten n';

  @override
  String get settings_keep_latest => 'Letzte Episoden behalten';

  @override
  String get settings_keep_latest_hint =>
      'Behält pro Podcast die neuesten n Episoden.';

  @override
  String get settings_delete_after_heard_label =>
      'Nach „gehört” in x Stunden löschen';

  @override
  String get settings_delete_after_hours => 'Löschen nach (Stunden)';

  @override
  String get settings_delete_after_hint =>
      'Nach dem Anhören automatisch nach x Stunden entfernen.';

  @override
  String get settings_zero_off => '0 = AUS';

  @override
  String get settings_autodownload_subscriptions =>
      'Automatisch abonnierte Episoden herunterladen';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Neue Episoden von abonnierten Podcasts automatisch herunterladen.';

  @override
  String get profileScreenNoRecentlyPlayed => 'Noch nichts kürzlich gehört.';

  @override
  String get profileScreenSubscriptionsTitle => 'Abonnierte Sendungen';

  @override
  String get profileScreenAppIdTitle => 'App-ID';

  @override
  String get profileScreenIdCopied => 'ID kopiert';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Wiedergabegeschwindigkeit';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonCount => 'Anzahl';

  @override
  String get commonDone => 'Fertig';
}
