// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Klubradio Archive';

  @override
  String get downloadListTitle => 'Downloads';

  @override
  String get downloadStatusQueued => 'Queued';

  @override
  String get downloadStatusNotDownloaded => 'Not Downloaded';

  @override
  String get downloadStatusDownloaded => 'Downloaded';

  @override
  String get downloadStatusDownloading => 'Downloading';

  @override
  String get downloadStatusFailed => 'Failed';

  @override
  String get downloadActionRetry => 'Retry';

  @override
  String get downloadActionCancel => 'Cancel';

  @override
  String get downloadActionDelete => 'Delete';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'No Downloads Yet';

  @override
  String get aboutScreenAppBarTitle => 'About the Application';

  @override
  String get aboutScreenAppNameDetail => 'Klubradio Archive Application';

  @override
  String get aboutScreenPurpose =>
      'The purpose of the application is to provide easy access to Klubrádió\'s archived programs and to allow the creation of RSS feeds for podcast players.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'This is a community project that serves to support Klubrádió. All content is freely available on the radio\'s official website.';

  @override
  String get aboutScreenContactInfo =>
      'Contact: info@klubradio.hu (content), multilevelstudios@gmail.com (developer contact)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorDialogTitle => 'Error';

  @override
  String get unexpectedError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'An error occurred: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Subscription successful!';

  @override
  String get podcastDetailSubscribeButton => 'Subscribe';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'No subscriptions yet — discover podcasts and tap “Subscribe”.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Subscribed Shows';

  @override
  String get homeScreenRecentEpisodesTitle => 'Recent Episodes';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Recently Played';

  @override
  String get themeSettingSystemDefault => 'System Default';

  @override
  String get themeSettingLight => 'Light';

  @override
  String get themeSettingDark => 'Dark';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Support Klubradio';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Open the support page in your browser.';

  @override
  String get settingsScreenSupportDeveloperTitle => 'Support the App Developer';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Voluntary donation for further development.';

  @override
  String get themeSettingsSectionTitle => 'Theme Settings';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavDiscover => 'Discover';

  @override
  String get bottomNavSearch => 'Search';

  @override
  String get bottomNavDownloads => 'Downloads';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get bottomNavSettings => 'Settings';

  @override
  String get playbackSettingsTitle => 'Playback Settings';

  @override
  String get playbackSettingsSpeedLabel => 'Playback speed:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatic downloads:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodes',
      one: '1 episode',
      zero: 'No episodes',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" selected.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Top Shows';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Recommended Shows';

  @override
  String get discoverScreenTrendingTitle => 'Trending';

  @override
  String get discoverScreenNoTopShows => 'No featured shows available.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'No recommendations available. Please refresh the data later.';

  @override
  String get trendingPodcastsNoShows => 'No trending shows on the list.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'You haven\'t subscribed to any shows yet.';

  @override
  String get recentSearchesNoHistory => 'No search history yet.';

  @override
  String get searchBarHintText => 'Shows, hosts, keywords...';

  @override
  String get searchResultsNoResults => 'No results found for your search.';

  @override
  String get searchScreenInitialPrompt => 'Find your favorite shows or hosts.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'An error occurred: $errorDetails';
  }

  @override
  String get errorParsingData => 'There was an issue processing the data.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get profileScreenNoEmail => 'No email address provided';

  @override
  String get profileScreenDownloadSettingsTitle => 'Download Settings';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatic Downloads';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Number of episodes: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Recently Played Episodes';

  @override
  String get profileScreenFavoritesTitle => 'Favorites';

  @override
  String get profileScreenNoFavoriteEpisodes => 'No favorite episodes yet.';

  @override
  String get profileScreenGuestUserDisplayName => 'Guest User';

  @override
  String get aboutScreenLicenseTitle => 'License / Legal';

  @override
  String get aboutScreenLicenseSummary =>
      'Open the license and legal information.';

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
    return 'An error occurred while loading episodes: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Subscribe';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Unsubscribe';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Subscribed successfully!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess =>
      'Unsubscribed successfully!';

  @override
  String get unsubscribeDialogTitle => 'Unsubscribe';

  @override
  String get unsubscribeDialogContent =>
      'Do you want to delete the downloaded episodes for this podcast?';

  @override
  String get unsubscribeDialogDeleteButton => 'Delete Episodes';

  @override
  String get unsubscribeDialogKeepButton => 'Keep Episodes';

  @override
  String get nowPlayingScreenTitle => 'Now Playing';

  @override
  String get nowPlayingScreenNoEpisode => 'No episode is currently playing.';

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
      'Sorry, the selected show could not be found.';

  @override
  String get podcastListItem_subscribed => 'Subscribed';

  @override
  String get podcastListItem_unsubscribe => 'Unsubscribe';

  @override
  String get podcastListItem_subscribe => 'Subscribe';

  @override
  String get podcastListItem_unsubscribed => 'Unsubscribed';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió show';

  @override
  String get podcastListItem_openDetails => 'Open podcast details';

  @override
  String get downloads_tab_active => 'Active';

  @override
  String get downloads_tab_done => 'Completed';

  @override
  String get downloads_empty_active => 'No active downloads';

  @override
  String get downloads_empty_done => 'No completed downloads';

  @override
  String get downloads_status_waiting => 'Waiting';

  @override
  String get downloads_status_running => 'Downloading';

  @override
  String get downloads_status_done => 'Completed';

  @override
  String get downloads_status_failed => 'Failed';

  @override
  String get downloads_status_canceled => 'Canceled';

  @override
  String get downloads_status_unknown => 'Unknown';

  @override
  String get downloads_action_pause => 'Pause';

  @override
  String get downloads_action_resume => 'Resume';

  @override
  String get downloads_action_cancel => 'Cancel';

  @override
  String get downloads_action_delete => 'Delete';

  @override
  String get ep_action_resume => 'Resume';

  @override
  String get ep_action_downloaded => 'Downloaded';

  @override
  String get ep_action_retry => 'Retry';

  @override
  String get ep_action_download => 'Download';

  @override
  String get settings_title_downloads => 'Downloads';

  @override
  String get settings_wifi_only => 'Wi-Fi only';

  @override
  String get settings_wifi_only_mobile_default => 'Default on mobile: ON';

  @override
  String get settings_wifi_only_desktop_default => 'Default on desktop: OFF';

  @override
  String get settings_max_parallel => 'Max concurrent downloads';

  @override
  String get settings_retention_section => 'Retention';

  @override
  String get settings_keep_all => 'Keep all';

  @override
  String get settings_keep_latest_label => 'Keep only the last n';

  @override
  String get settings_keep_latest => 'Keep latest episodes';

  @override
  String get settings_keep_latest_hint =>
      'Keeps the newest n episodes per podcast.';

  @override
  String get settings_delete_after_heard_label =>
      'Delete x hours after listened';

  @override
  String get settings_delete_after_hours => 'Delete after (hours)';

  @override
  String get settings_delete_after_hint =>
      'Automatically remove x hours after playback.';

  @override
  String get settings_zero_off => '0 = OFF';

  @override
  String get settings_autodownload_subscriptions =>
      'Autodownload subscribed episodes';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Automatically download new episodes from subscribed podcasts.';

  @override
  String get profileScreenNoRecentlyPlayed =>
      'No recently played episodes yet.';

  @override
  String get profileScreenSubscriptionsTitle => 'Subscribed shows';

  @override
  String get profileScreenAppIdTitle => 'App ID';

  @override
  String get profileScreenIdCopied => 'ID copied';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Playback speed';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonCount => 'Count';

  @override
  String get commonDone => 'Fertig';
}
