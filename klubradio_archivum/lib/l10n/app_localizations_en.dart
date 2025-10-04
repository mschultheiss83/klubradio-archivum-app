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
}
