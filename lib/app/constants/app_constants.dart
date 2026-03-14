import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;

  // Font Sizes
  static const double fontSizeXS = 11.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 13.0;
  static const double fontSizeL = 14.0;
  static const double fontSizeXL = 16.0;
  static const double fontSizeXXL = 18.0;

  // Font Weights
  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Avatar Sizes
  static const double avatarSizeStory = 56.0;
  static const double avatarSizePost = 32.0;
  static const double avatarSizePostLarge = 36.0;

  // Story Ring
  static const double storyRingWidth = 2.5;
  static const double storyRingGap = 2.0;

  // Post
  static const double postImageAspectRatio = 4 / 5;
  static const double postActionsIconSize = 24.0;
  static const double postActionsIconSizeSave = 22.0;

  // Bottom Nav
  static const double bottomNavIconSize = 26.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusCircle = 999.0;

  // Dot Indicator
  static const double dotSizeActive = 6.0;
  static const double dotSizeInactive = 5.0;
  static const double dotSpacing = 4.0;

  // Durations
  static const Duration shimmerDelay = Duration(milliseconds: 1500);
  static const Duration storiesDelay = Duration(milliseconds: 500);
  static const Duration snackbarDuration = Duration(seconds: 3);
  static const Duration zoomAnimDuration = Duration(milliseconds: 200);
  static const Duration likeAnimDuration = Duration(milliseconds: 350);

  // Pagination
  static const int paginationTriggerOffset = 2;
  static const int postsPerPage = 10;

  // App Bar
  static const double appBarHeight = 44.0;
  static const double appBarLogoFontSize = 28.0;

  // Stories tray
  static const double storiesTrayHeight = 104.0;
  static const double storyItemWidth = 72.0;
}
