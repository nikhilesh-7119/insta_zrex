import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Instagram gradient (logo + story ring)
  static const List<Color> instagramGradient = [
    Color(0xFF833AB4),
    Color(0xFFFD1D1D),
    Color(0xFFFCB045),
  ];

  // Story ring gradient
  static const List<Color> storyRingGradient = [
    Color(0xFFF09433),
    Color(0xFFE6683C),
    Color(0xFFDC2743),
    Color(0xFFCC2366),
    Color(0xFFBC1888),
  ];

  // Story ring seen color
  static const Color storySeenColor = Color(0xFFDBDBDB);
  static const Color storySeenColorDark = Color(0xFF3D3D3D);

  // Like red
  static const Color likeRed = Color(0xFFED4956);

  // Instagram blue (dot indicator active, links)
  static const Color instagramBlue = Color(0xFF3897F0);

  // Verified badge
  static const Color verifiedBlue = Color(0xFF1DA1F2);

  // ─── Light Mode ───
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFDBDBDB);
  static const Color lightText = Color(0xFF000000);
  static const Color lightSubText = Color(0xFF8E8E8E);
  static const Color lightIcon = Color(0xFF262626);
  static const Color lightActionIcon = Color(0xFF262626);
  static const Color lightPlaceholder = Color(0xFFFAFAFA);
  static const Color lightShimmerBase = Color(0xFFEAEAEA);
  static const Color lightShimmerHighlight = Color(0xFFF5F5F5);

  // ─── Dark Mode ───
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkDivider = Color(0xFF262626);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSubText = Color(0xFF737373);
  static const Color darkIcon = Color(0xFFFFFFFF);
  static const Color darkActionIcon = Color(0xFFFFFFFF);
  static const Color darkPlaceholder = Color(0xFF1C1C1C);
  static const Color darkShimmerBase = Color(0xFF2A2A2A);
  static const Color darkShimmerHighlight = Color(0xFF3A3A3A);

  // Follow button
  static const Color followButtonBg = Color(0xFF0095F6);
  static const Color followButtonText = Color(0xFFFFFFFF);

  // Snackbar
  static const Color snackbarBg = Color(0xFF262626);
  static const Color snackbarText = Color(0xFFFFFFFF);
}
