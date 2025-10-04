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
  String get podcastDetailScreenUnsubscribeSuccess =>
      'Abonnement erfolgreich beendet!';

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
}
