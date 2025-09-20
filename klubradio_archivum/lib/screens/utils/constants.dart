import 'package:flutter/material.dart';

const double kDefaultPadding = 16;
const double kSmallPadding = 8;
const double kCardElevation = 1.5;
const double kListItemSpacing = 12;
const double kLargeAvatarRadius = 36;

const Duration kShortAnimationDuration = Duration(milliseconds: 250);
const Duration kMediumAnimationDuration = Duration(milliseconds: 400);

const String kDonationUrlDeveloper =
    'https://www.paypal.com/paypalme/klubradioapp';
const String kDonationUrlStation = 'https://klubradio.hu/tamogasson-minket';

const List<IconData> kCategoryIcons = <IconData>[
  Icons.public,
  Icons.mic,
  Icons.newspaper,
  Icons.theaters,
  Icons.sports_soccer,
  Icons.science,
  Icons.music_note,
  Icons.policy,
];

const TextStyle kSectionTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.black87,
);

const TextStyle kSecondaryTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.black54,
);

const TextStyle kChipTextStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const String kPaymentWarningText =
    'Figyelem! A Klubrádió tartalmai ingyenesen elérhetők. Ha fizetési kérésbe '
    'botlik, az biztosan nem a Klubrádiótól származik.';
