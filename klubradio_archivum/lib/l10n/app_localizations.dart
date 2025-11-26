import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('hu'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Klubradio Archive'**
  String get appName;

  /// Title for the downloads screen
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloadListTitle;

  /// Download status: Item is in queue to be downloaded
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get downloadStatusQueued;

  /// Download status: Item has not been downloaded yet
  ///
  /// In en, this message translates to:
  /// **'Not Downloaded'**
  String get downloadStatusNotDownloaded;

  /// Download status: Item has been successfully downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get downloadStatusDownloaded;

  /// Download status: Item is currently being downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloadStatusDownloading;

  /// Download status: Item download has failed
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get downloadStatusFailed;

  /// Button text to retry a failed download
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get downloadActionRetry;

  /// Button text to cancel an ongoing download
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get downloadActionCancel;

  /// Button text to delete a downloaded item
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get downloadActionDelete;

  /// Label showing the download progress percentage
  ///
  /// In en, this message translates to:
  /// **'{progressPercentage}%'**
  String downloadProgressLabel(int progressPercentage);

  /// Message shown when the download list is empty
  ///
  /// In en, this message translates to:
  /// **'No Downloads Yet'**
  String get noDownloads;

  /// Title for the AppBar on the About screen
  ///
  /// In en, this message translates to:
  /// **'About the Application'**
  String get aboutScreenAppBarTitle;

  /// The name of the application on the About screen
  ///
  /// In en, this message translates to:
  /// **'Klubradio Archive Application'**
  String get aboutScreenAppNameDetail;

  /// Description of the application's purpose
  ///
  /// In en, this message translates to:
  /// **'The purpose of the application is to provide easy access to Klubrádió\'s archived programs and to allow the creation of RSS feeds for podcast players.'**
  String get aboutScreenPurpose;

  /// Information about the community nature of the project and content availability
  ///
  /// In en, this message translates to:
  /// **'This is a community project that serves to support Klubrádió. All content is freely available on the radio\'s official website.'**
  String get aboutScreenCommunityProjectInfo;

  /// Contact information
  ///
  /// In en, this message translates to:
  /// **'Contact: info@klubradio.hu (content), multilevelstudios@gmail.com (developer contact)'**
  String get aboutScreenContactInfo;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Setting to select the theme (e.g., Light/Dark)
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Setting to select the application language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Generic OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Generic Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Error dialog window title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorDialogTitle;

  /// Generic error message for unexpected issues
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get unexpectedError;

  /// Error message when loading podcast episodes fails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {errorDetails}'**
  String podcastDetailErrorLoading(String errorDetails);

  /// Notification on successful podcast subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription successful!'**
  String get podcastDetailSubscriptionSuccess;

  /// Button label to subscribe to the podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastDetailSubscribeButton;

  /// No description provided for @homeScreenSubscribedPodcastsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet — discover podcasts and tap “Subscribe”.'**
  String get homeScreenSubscribedPodcastsEmptyHint;

  /// Section title for subscribed podcasts on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Subscribed Shows'**
  String get homeScreenSubscribedPodcastsTitle;

  /// Section title for recent episodes on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Recent Episodes'**
  String get homeScreenRecentEpisodesTitle;

  /// Section title for recently played episodes on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Recently Played'**
  String get homeScreenRecentlyPlayedTitle;

  /// Option to use the system's theme setting.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSettingSystemDefault;

  /// Option to select the light theme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeSettingLight;

  /// Option to select the dark theme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeSettingDark;

  /// Title for the Support Klubradio section on the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Support Klubradio'**
  String get settingsScreenSupportKlubradioTitle;

  /// Subtitle for the Support Klubradio section.
  ///
  /// In en, this message translates to:
  /// **'Open the support page in your browser.'**
  String get settingsScreenSupportKlubradioSubtitle;

  /// Title for the Support App Developer section.
  ///
  /// In en, this message translates to:
  /// **'Support the App Developer'**
  String get settingsScreenSupportDeveloperTitle;

  /// Subtitle for the Support App Developer section.
  ///
  /// In en, this message translates to:
  /// **'Voluntary donation for further development.'**
  String get settingsScreenSupportDeveloperSubtitle;

  /// Section title for theme settings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettingsSectionTitle;

  /// Navigation tab label: Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// Navigation tab label: Discover
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get bottomNavDiscover;

  /// Navigation tab label: Search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get bottomNavSearch;

  /// Navigation tab label: Downloads
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get bottomNavDownloads;

  /// Navigation tab label: Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// Navigation tab label: Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomNavSettings;

  /// Section title for playback settings.
  ///
  /// In en, this message translates to:
  /// **'Playback Settings'**
  String get playbackSettingsTitle;

  /// Label for the playback speed setting.
  ///
  /// In en, this message translates to:
  /// **'Playback speed:'**
  String get playbackSettingsSpeedLabel;

  /// Format for displaying the playback speed value. Example: 1.5x
  ///
  /// In en, this message translates to:
  /// **'{speed}x'**
  String playbackSettingsSpeedValue(double speed);

  /// Label for the automatic downloads count setting.
  ///
  /// In en, this message translates to:
  /// **'Automatic downloads:'**
  String get playbackSettingsAutoDownloadLabel;

  /// Format for displaying the number of episodes to auto-download. Example: 5 episodes
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{No episodes} =1{1 episode} other{{count} episodes}}'**
  String playbackSettingsAutoDownloadValue(int count);

  /// Feedback message shown when a show is selected from a list of chips.
  ///
  /// In en, this message translates to:
  /// **'\"{showTitle}\" selected.'**
  String showSelectedFeedback(String showTitle);

  /// Title for the featured/top categories section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Top Shows'**
  String get discoverScreenFeaturedCategoriesTitle;

  /// Title for the recommended shows section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Recommended Shows'**
  String get discoverScreenRecommendedShowsTitle;

  /// Title for the trending podcasts section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get discoverScreenTrendingTitle;

  /// No description provided for @discoverScreenNoTopShows.
  ///
  /// In en, this message translates to:
  /// **'No featured shows available.'**
  String get discoverScreenNoTopShows;

  /// Message shown when there are no recommended podcasts to display.
  ///
  /// In en, this message translates to:
  /// **'No recommendations available. Please refresh the data later.'**
  String get recommendedPodcastsNoRecommendations;

  /// Message shown when there are no trending podcasts to display.
  ///
  /// In en, this message translates to:
  /// **'No trending shows on the list.'**
  String get trendingPodcastsNoShows;

  /// Message shown when the user has not subscribed to any podcasts.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t subscribed to any shows yet.'**
  String get subscribedPodcastsNoSubscriptions;

  /// Message shown when there are no recent searches to display.
  ///
  /// In en, this message translates to:
  /// **'No search history yet.'**
  String get recentSearchesNoHistory;

  /// Hint text displayed in the search bar.
  ///
  /// In en, this message translates to:
  /// **'Shows, hosts, keywords...'**
  String get searchBarHintText;

  /// Message shown when a search yields no results.
  ///
  /// In en, this message translates to:
  /// **'No results found for your search.'**
  String get searchResultsNoResults;

  /// Initial prompt message on the search screen before any search is performed.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite shows or hosts.'**
  String get searchScreenInitialPrompt;

  /// Error message displayed on the search screen if a search fails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {errorDetails}'**
  String searchScreenErrorMessage(String errorDetails);

  /// Error message shown when data parsing fails.
  ///
  /// In en, this message translates to:
  /// **'There was an issue processing the data.'**
  String get errorParsingData;

  /// Generic error message for unknown issues.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorUnknown;

  /// Text shown on the profile screen when the user's email is not available.
  ///
  /// In en, this message translates to:
  /// **'No email address provided'**
  String get profileScreenNoEmail;

  /// Title for the download settings section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Download Settings'**
  String get profileScreenDownloadSettingsTitle;

  /// Title for the automatic downloads option in profile settings.
  ///
  /// In en, this message translates to:
  /// **'Automatic Downloads'**
  String get profileScreenAutoDownloadsTitle;

  /// Subtitle indicating the number of episodes set for automatic download.
  ///
  /// In en, this message translates to:
  /// **'Number of episodes: {count}'**
  String profileScreenAutoDownloadsSubtitle(int count);

  /// Title for the recently played episodes section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Recently Played Episodes'**
  String get profileScreenRecentlyPlayedTitle;

  /// Title for the favorites section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileScreenFavoritesTitle;

  /// Message shown when the user has no favorite episodes.
  ///
  /// In en, this message translates to:
  /// **'No favorite episodes yet.'**
  String get profileScreenNoFavoriteEpisodes;

  /// Default display name for a guest user or when the name is not set.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get profileScreenGuestUserDisplayName;

  /// Title for the card that opens the license/legal information.
  ///
  /// In en, this message translates to:
  /// **'License / Legal'**
  String get aboutScreenLicenseTitle;

  /// Short subtitle/summary shown under the license card title.
  ///
  /// In en, this message translates to:
  /// **'Open the license and legal information.'**
  String get aboutScreenLicenseSummary;

  /// Title for the card that shows the current app version/build.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutScreenVersionTitle;

  /// Formatted version string with placeholders for version and build number.
  ///
  /// In en, this message translates to:
  /// **'{version} (Build {build})'**
  String aboutScreenVersionFormat(String version, String build);

  /// Label for the list of hosts on the podcast info card.
  ///
  /// In en, this message translates to:
  /// **'{hostNames}'**
  String podcastInfoCardHostsLabel(String hostNames);

  /// Error message when episodes for a podcast fail to load.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading episodes: {errorDetails}'**
  String podcastDetailScreenErrorMessage(String errorDetails);

  /// Text for the button to subscribe to a podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastDetailScreenSubscribeButton;

  /// Text for the button to unsubscribe from a podcast.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get podcastDetailScreenUnsubscribeButton;

  /// Snackbar message shown after successfully subscribing to a podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribed successfully!'**
  String get podcastDetailScreenSubscribeSuccess;

  /// Snackbar message shown after successfully unsubscribing from a podcast.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed successfully!'**
  String get podcastDetailScreenUnsubscribeSuccess;

  /// No description provided for @unsubscribeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribeDialogTitle;

  /// No description provided for @unsubscribeDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the downloaded episodes for this podcast?'**
  String get unsubscribeDialogContent;

  /// No description provided for @unsubscribeDialogDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Episodes'**
  String get unsubscribeDialogDeleteButton;

  /// No description provided for @unsubscribeDialogKeepButton.
  ///
  /// In en, this message translates to:
  /// **'Keep Episodes'**
  String get unsubscribeDialogKeepButton;

  /// Title for the 'Now Playing' screen.
  ///
  /// In en, this message translates to:
  /// **'Now Playing'**
  String get nowPlayingScreenTitle;

  /// Message shown on the 'Now Playing' screen when no episode has been selected.
  ///
  /// In en, this message translates to:
  /// **'No episode is currently playing.'**
  String get nowPlayingScreenNoEpisode;

  /// Formats a duration with hours and minutes. Example: 1h 23m
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationInHoursAndMinutes(int hours, int minutes);

  /// Formats a duration with only minutes. Example: 45m
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String durationInMinutes(int minutes);

  /// Error message when a podcast selected from a list can't be fetched.
  ///
  /// In en, this message translates to:
  /// **'Sorry, the selected show could not be found.'**
  String get podcastNotFoundError;

  /// No description provided for @podcastListItem_subscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get podcastListItem_subscribed;

  /// No description provided for @podcastListItem_unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get podcastListItem_unsubscribe;

  /// No description provided for @podcastListItem_subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastListItem_subscribe;

  /// No description provided for @podcastListItem_unsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed'**
  String get podcastListItem_unsubscribed;

  /// No description provided for @podcastListItem_subtitleFallback.
  ///
  /// In en, this message translates to:
  /// **'Klubrádió show'**
  String get podcastListItem_subtitleFallback;

  /// No description provided for @podcastListItem_openDetails.
  ///
  /// In en, this message translates to:
  /// **'Open podcast details'**
  String get podcastListItem_openDetails;

  /// No description provided for @downloads_tab_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get downloads_tab_active;

  /// No description provided for @downloads_tab_done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get downloads_tab_done;

  /// No description provided for @downloads_empty_active.
  ///
  /// In en, this message translates to:
  /// **'No active downloads'**
  String get downloads_empty_active;

  /// No description provided for @downloads_empty_done.
  ///
  /// In en, this message translates to:
  /// **'No completed downloads'**
  String get downloads_empty_done;

  /// No description provided for @downloads_status_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get downloads_status_waiting;

  /// No description provided for @downloads_status_running.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloads_status_running;

  /// No description provided for @downloads_status_done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get downloads_status_done;

  /// No description provided for @downloads_status_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get downloads_status_failed;

  /// No description provided for @downloads_status_canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get downloads_status_canceled;

  /// No description provided for @downloads_status_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get downloads_status_unknown;

  /// No description provided for @downloads_action_pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get downloads_action_pause;

  /// No description provided for @downloads_action_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get downloads_action_resume;

  /// No description provided for @downloads_action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get downloads_action_cancel;

  /// No description provided for @downloads_action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get downloads_action_delete;

  /// No description provided for @ep_action_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get ep_action_resume;

  /// No description provided for @ep_action_downloaded.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get ep_action_downloaded;

  /// No description provided for @ep_action_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get ep_action_retry;

  /// No description provided for @ep_action_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get ep_action_download;

  /// No description provided for @settings_title_downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get settings_title_downloads;

  /// No description provided for @settings_wifi_only.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi only'**
  String get settings_wifi_only;

  /// No description provided for @settings_wifi_only_mobile_default.
  ///
  /// In en, this message translates to:
  /// **'Default on mobile: ON'**
  String get settings_wifi_only_mobile_default;

  /// No description provided for @settings_wifi_only_desktop_default.
  ///
  /// In en, this message translates to:
  /// **'Default on desktop: OFF'**
  String get settings_wifi_only_desktop_default;

  /// No description provided for @settings_max_parallel.
  ///
  /// In en, this message translates to:
  /// **'Max concurrent downloads'**
  String get settings_max_parallel;

  /// No description provided for @settings_retention_section.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get settings_retention_section;

  /// No description provided for @settings_keep_all.
  ///
  /// In en, this message translates to:
  /// **'Keep all'**
  String get settings_keep_all;

  /// No description provided for @settings_keep_latest_label.
  ///
  /// In en, this message translates to:
  /// **'Keep only the last n'**
  String get settings_keep_latest_label;

  /// No description provided for @settings_keep_latest.
  ///
  /// In en, this message translates to:
  /// **'Keep latest episodes'**
  String get settings_keep_latest;

  /// No description provided for @settings_keep_latest_hint.
  ///
  /// In en, this message translates to:
  /// **'Keeps the newest n episodes per podcast.'**
  String get settings_keep_latest_hint;

  /// No description provided for @settings_delete_after_heard_label.
  ///
  /// In en, this message translates to:
  /// **'Delete x hours after listened'**
  String get settings_delete_after_heard_label;

  /// No description provided for @settings_delete_after_hours.
  ///
  /// In en, this message translates to:
  /// **'Delete after (hours)'**
  String get settings_delete_after_hours;

  /// No description provided for @settings_delete_after_hint.
  ///
  /// In en, this message translates to:
  /// **'Automatically remove x hours after playback.'**
  String get settings_delete_after_hint;

  /// No description provided for @settings_zero_off.
  ///
  /// In en, this message translates to:
  /// **'0 = OFF'**
  String get settings_zero_off;

  /// No description provided for @settings_autodownload_subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Autodownload subscribed episodes'**
  String get settings_autodownload_subscriptions;

  /// No description provided for @settings_autodownload_subscriptions_hint.
  ///
  /// In en, this message translates to:
  /// **'Automatically download new episodes from subscribed podcasts.'**
  String get settings_autodownload_subscriptions_hint;

  /// No description provided for @profileScreenNoRecentlyPlayed.
  ///
  /// In en, this message translates to:
  /// **'No recently played episodes yet.'**
  String get profileScreenNoRecentlyPlayed;

  /// No description provided for @profileScreenSubscriptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscribed shows'**
  String get profileScreenSubscriptionsTitle;

  /// No description provided for @profileScreenAppIdTitle.
  ///
  /// In en, this message translates to:
  /// **'App ID'**
  String get profileScreenAppIdTitle;

  /// No description provided for @profileScreenIdCopied.
  ///
  /// In en, this message translates to:
  /// **'ID copied'**
  String get profileScreenIdCopied;

  /// No description provided for @profileScreenPlaybackSpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get profileScreenPlaybackSpeedTitle;

  /// No description provided for @profileScreenPlaybackSpeedValue.
  ///
  /// In en, this message translates to:
  /// **'{value}×'**
  String profileScreenPlaybackSpeedValue(Object value);

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get commonCount;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Fertig'**
  String get commonDone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'hu'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hu':
      return AppLocalizationsHu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
