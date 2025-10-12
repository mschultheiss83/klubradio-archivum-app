// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appName => 'Klubrádió Archívum';

  @override
  String get downloadListTitle => 'Letöltések';

  @override
  String get downloadStatusQueued => 'Várólistán';

  @override
  String get downloadStatusNotDownloaded => 'Nincs letöltve';

  @override
  String get downloadStatusDownloaded => 'Letöltve';

  @override
  String get downloadStatusDownloading => 'Letöltés';

  @override
  String get downloadStatusFailed => 'Sikertelen';

  @override
  String get downloadActionRetry => 'Újra';

  @override
  String get downloadActionCancel => 'Mégse';

  @override
  String get downloadActionDelete => 'Törlés';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Még nincsenek letöltések';

  @override
  String get aboutScreenAppBarTitle => 'Az alkalmazásról';

  @override
  String get aboutScreenAppNameDetail => 'Klubrádió archívum alkalmazás';

  @override
  String get aboutScreenPurpose =>
      'Az alkalmazás célja, hogy egyszerű hozzáférést biztosítson a Klubrádió archív műsoraihoz, és lehetőséget adjon RSS feedek létrehozására podcast lejátszók számára.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Ez egy közösségi projekt, amely a Klubrádió támogatását szolgálja. Minden tartalom szabadon elérhető a rádió hivatalos oldalán.';

  @override
  String get aboutScreenContactInfo =>
      'Kapcsolat: info@klubradio.hu (tartalom), multilevelstudios@gmail.com (fejlesztői elérhetőség)';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsTheme => 'Téma';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Mégse';

  @override
  String get errorDialogTitle => 'Hiba';

  @override
  String get unexpectedError =>
      'Váratlan hiba történt. Kérjük, próbálja újra később.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'Hiba történt: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Feliratkozás sikeres!';

  @override
  String get podcastDetailSubscribeButton => 'Feliratkozás';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Feliratkozott műsorok';

  @override
  String get homeScreenRecentEpisodesTitle => 'Legutóbbi epizódok';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Legutóbb hallgatott';

  @override
  String get themeSettingSystemDefault => 'Rendszer alapértelmezett';

  @override
  String get themeSettingLight => 'Világos';

  @override
  String get themeSettingDark => 'Sötét';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Támogasd a Klubrádiót';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Nyisd meg a támogatási oldalt a böngészőben.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'Támogasd az alkalmazás fejlesztőjét';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Önkéntes adomány a további fejlesztésekhez.';

  @override
  String get themeSettingsSectionTitle => 'Téma beállítások';

  @override
  String get bottomNavHome => 'Főoldal';

  @override
  String get bottomNavDiscover => 'Felfedezés';

  @override
  String get bottomNavSearch => 'Keresés';

  @override
  String get bottomNavDownloads => 'Letöltések';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Beállítások';

  @override
  String get playbackSettingsTitle => 'Lejátszási beállítások';

  @override
  String get playbackSettingsSpeedLabel => 'Lejátszási sebesség:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatikus letöltések:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count epizód',
      one: '1 epizód',
      zero: 'Nincs epizód',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" kiválasztva.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Kiemelt műsorok';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Ajánlott műsorok';

  @override
  String get discoverScreenTrendingTitle => 'Felkapott';

  @override
  String get discoverScreenNoTopShows => 'Nincsenek kiemelt műsorok.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Nincs elérhető ajánlás. Frissítsd az adatokat később.';

  @override
  String get trendingPodcastsNoShows => 'Nincs felkapott műsor a listán.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Még nem iratkoztál fel egy műsorra sem.';

  @override
  String get recentSearchesNoHistory => 'Még nincs keresési előzmény.';

  @override
  String get searchBarHintText => 'Műsorok, műsorvezetők, kulcsszavak...';

  @override
  String get searchResultsNoResults => 'Nincs találat a megadott keresésre.';

  @override
  String get searchScreenInitialPrompt =>
      'Keresd meg kedvenc műsoraidat vagy műsorvezetőidet.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'Hiba történt: $errorDetails';
  }

  @override
  String get errorParsingData => 'Hiba történt az adatok feldolgozása során.';

  @override
  String get errorUnknown => 'Ismeretlen hiba történt.';

  @override
  String get profileScreenNoEmail => 'Nincs megadva e-mail cím';

  @override
  String get profileScreenDownloadSettingsTitle => 'Letöltési beállítások';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatikus letöltések';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Epizódok száma: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Legutóbb hallgatott epizódok';

  @override
  String get profileScreenFavoritesTitle => 'Kedvencek';

  @override
  String get profileScreenNoFavoriteEpisodes => 'Nincsenek kedvenc epizódok.';

  @override
  String get profileScreenGuestUserDisplayName => 'Vendég felhasználó';

  @override
  String get aboutScreenLicenseTitle => 'Licenc / Jogi információk';

  @override
  String get aboutScreenLicenseSummary =>
      'Licenc és jogi információk megnyitása.';

  @override
  String get aboutScreenVersionTitle => 'Verzió';

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
    return 'Hiba történt az epizódok betöltésekor: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Feliratkozás';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Leiratkozás';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Feliratkozás sikeres!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Leiratkozás sikeres!';

  @override
  String get nowPlayingScreenTitle => 'Most szól';

  @override
  String get nowPlayingScreenNoEpisode => 'Jelenleg nincs lejátszott epizód.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '$hours óra $minutes perc';
  }

  @override
  String durationInMinutes(int minutes) {
    return '$minutes perc';
  }

  @override
  String get podcastNotFoundError =>
      'Sajnos a kiválasztott műsor nem található.';

  @override
  String get podcastListItem_subscribed => 'Feliratkozva';

  @override
  String get podcastListItem_subscribe => 'Feliratkozás';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió műsor';

  @override
  String get podcastListItem_openDetails => 'Műsor részleteinek megnyitása';
}
