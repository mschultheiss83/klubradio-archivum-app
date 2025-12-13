// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appName => 'Arhiva Klubradio';

  @override
  String get downloadListTitle => 'Descărcări';

  @override
  String get downloadStatusQueued => 'În așteptare';

  @override
  String get downloadStatusNotDownloaded => 'Nu este descărcat';

  @override
  String get downloadStatusDownloaded => 'Descărcat';

  @override
  String get downloadStatusDownloading => 'Se descarcă';

  @override
  String get downloadStatusFailed => 'Eșuat';

  @override
  String get downloadActionRetry => 'Reîncercați';

  @override
  String get downloadActionCancel => 'Anulați';

  @override
  String get downloadActionDelete => 'Ștergeți';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Nicio descărcare încă';

  @override
  String get aboutScreenAppBarTitle => 'Despre aplicație';

  @override
  String get aboutScreenAppNameDetail => 'Aplicația Arhiva Klubradio';

  @override
  String get aboutScreenPurpose =>
      'Scopul aplicației este de a oferi acces ușor la programele arhivate ale Klubrádió și de a permite crearea de fluxuri RSS pentru playerele podcast.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Acesta este un proiect comunitar care servește la susținerea Klubrádió. Tot conținutul este disponibil gratuit pe site-ul oficial al radioului.';

  @override
  String get aboutScreenContactInfo =>
      'Contact: info@klubradio.hu (conținut), multilevelstudios@gmail.com (contact dezvoltator)';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get settingsTheme => 'Temă';

  @override
  String get settingsLanguage => 'Limbă';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anulați';

  @override
  String get errorDialogTitle => 'Eroare';

  @override
  String get unexpectedError =>
      'A apărut o eroare neașteptată. Vă rugăm să încercați din nou mai târziu.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'A apărut o eroare: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Abonare reușită!';

  @override
  String get podcastDetailSubscribeButton => 'Abonează-te';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'Nicio abonare încă — descoperiți podcasturi și atingeți „Abonează-te”.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Emisiuni abonate';

  @override
  String get homeScreenRecentEpisodesTitle => 'Episoade recente';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Redate recent';

  @override
  String get themeSettingSystemDefault => 'Implicit sistem';

  @override
  String get themeSettingLight => 'Luminos';

  @override
  String get themeSettingDark => 'Întunecat';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Sprijiniți Klubradio';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Deschideți pagina de suport în browserul dvs.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'Sprijiniți dezvoltatorul aplicației';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Donație voluntară pentru dezvoltare ulterioară.';

  @override
  String get themeSettingsSectionTitle => 'Setări temă';

  @override
  String get bottomNavHome => 'Acasă';

  @override
  String get bottomNavDiscover => 'Descoperiți';

  @override
  String get bottomNavSearch => 'Căutați';

  @override
  String get bottomNavDownloads => 'Descărcări';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Setări';

  @override
  String get playbackSettingsTitle => 'Setări redare';

  @override
  String get playbackSettingsSpeedLabel => 'Viteză redare:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Descărcări automate:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episoade',
      one: '1 episod',
      zero: 'Niciun episod',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" selectat.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Emisiuni populare';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Emisiuni recomandate';

  @override
  String get discoverScreenTrendingTitle => 'În tendințe';

  @override
  String get discoverScreenNoTopShows => 'Nicio emisiune populară disponibilă.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Nicio recomandare disponibilă. Vă rugăm să reîmprospătați datele mai târziu.';

  @override
  String get trendingPodcastsNoShows => 'Nicio emisiune în tendințe în listă.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Nu v-ați abonat încă la nicio emisiune.';

  @override
  String get recentSearchesNoHistory => 'Niciun istoric de căutări încă.';

  @override
  String get searchBarHintText => 'Emisiuni, gazde, cuvinte cheie...';

  @override
  String get searchResultsNoResults =>
      'Nu s-au găsit rezultate pentru căutarea dvs.';

  @override
  String get searchScreenInitialPrompt =>
      'Găsiți emisiunile sau gazdele preferate.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'A apărut o eroare: $errorDetails';
  }

  @override
  String get errorParsingData => 'A apărut o problemă la procesarea datelor.';

  @override
  String get errorUnknown => 'A apărut o eroare necunoscută.';

  @override
  String get profileScreenNoEmail => 'Niciun email furnizat';

  @override
  String get profileScreenDownloadSettingsTitle => 'Setări descărcări';

  @override
  String get profileScreenAutoDownloadsTitle => 'Descărcări automate';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Număr de episoade: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Episoade redate recent';

  @override
  String get profileScreenFavoritesTitle => 'Favorite';

  @override
  String get profileScreenNoFavoriteEpisodes => 'Niciun episod favorit încă.';

  @override
  String get profileScreenGuestUserDisplayName => 'Utilizator invitat';

  @override
  String get aboutScreenLicenseTitle => 'Licență / Legal';

  @override
  String get aboutScreenLicenseSummary =>
      'Deschideți informațiile despre licență și legale.';

  @override
  String get aboutScreenVersionTitle => 'Versiune';

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
    return 'A apărut o eroare la încărcarea episoadelor: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Abonează-te';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Dezabonează-te';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Abonat cu succes!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Dezabonat cu succes!';

  @override
  String get unsubscribeDialogTitle => 'Dezabonare';

  @override
  String get unsubscribeDialogContent =>
      'Doriți să ștergeți episoadele descărcate pentru acest podcast?';

  @override
  String get unsubscribeDialogDeleteButton => 'Ștergeți episoadele';

  @override
  String get unsubscribeDialogKeepButton => 'Păstrați episoadele';

  @override
  String get nowPlayingScreenTitle => 'Se redă acum';

  @override
  String get nowPlayingScreenNoEpisode =>
      'Niciun episod nu se redă în prezent.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String durationInMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get podcastNotFoundError =>
      'Ne pare rău, emisiunea selectată nu a putut fi găsită.';

  @override
  String get podcastListItem_subscribed => 'Abonat';

  @override
  String get podcastListItem_unsubscribe => 'Dezabonare';

  @override
  String get podcastListItem_subscribe => 'Abonare';

  @override
  String get podcastListItem_unsubscribed => 'Dezabonat';

  @override
  String get podcastListItem_subtitleFallback => 'Emisiune Klubrádió';

  @override
  String get podcastListItem_openDetails => 'Deschide detaliile podcastului';

  @override
  String get downloads_tab_active => 'Active';

  @override
  String get downloads_tab_done => 'Finalizate';

  @override
  String get downloads_empty_active => 'Nicio descărcare activă';

  @override
  String get downloads_empty_done => 'Nicio descărcare finalizată';

  @override
  String get downloads_status_waiting => 'În așteptare';

  @override
  String get downloads_status_running => 'Se descarcă';

  @override
  String get downloads_status_done => 'Finalizat';

  @override
  String get downloads_status_failed => 'Eșuat';

  @override
  String get downloads_status_canceled => 'Anulat';

  @override
  String get downloads_status_unknown => 'Necunoscut';

  @override
  String get downloads_action_pause => 'Pauză';

  @override
  String get downloads_action_resume => 'Reluați';

  @override
  String get downloads_action_cancel => 'Anulați';

  @override
  String get downloads_action_delete => 'Ștergeți';

  @override
  String get ep_action_resume => 'Reluați';

  @override
  String get ep_action_downloaded => 'Descărcat';

  @override
  String get ep_action_retry => 'Reîncercați';

  @override
  String get ep_action_download => 'Descărcați';

  @override
  String get settings_title_downloads => 'Descărcări';

  @override
  String get settings_wifi_only => 'Doar Wi-Fi';

  @override
  String get settings_wifi_only_mobile_default => 'Implicit pe mobil: ACTIVAT';

  @override
  String get settings_wifi_only_desktop_default =>
      'Implicit pe desktop: DEZACTIVAT';

  @override
  String get settings_max_parallel => 'Descărcări concurente maxime';

  @override
  String get settings_retention_section => 'Retenție';

  @override
  String get settings_keep_all => 'Păstrați toate';

  @override
  String get settings_keep_latest_label => 'Păstrați doar ultimele n';

  @override
  String get settings_keep_latest => 'Păstrați ultimele episoade';

  @override
  String get settings_keep_latest_hint =>
      'Păstrează cele mai noi n episoade per podcast.';

  @override
  String get settings_delete_after_heard_label =>
      'Ștergeți la x ore după ascultare';

  @override
  String get settings_delete_after_hours => 'Ștergeți după (ore)';

  @override
  String get settings_delete_after_hint =>
      'Eliminați automat la x ore după redare.';

  @override
  String get settings_zero_off => '0 = DEZACTIVAT';

  @override
  String get settings_autodownload_subscriptions =>
      'Descărcați automat episoadele abonate';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Descărcați automat episoadele noi de la podcasturile abonate.';

  @override
  String get profileScreenNoRecentlyPlayed =>
      'Niciun episod redat recent încă.';

  @override
  String get profileScreenSubscriptionsTitle => 'Emisiuni abonate';

  @override
  String get profileScreenAppIdTitle => 'ID aplicație';

  @override
  String get profileScreenIdCopied => 'ID copiat';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Viteză redare';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Anulați';

  @override
  String get commonCount => 'Număr';

  @override
  String get commonDone => 'Finalizat';
}
