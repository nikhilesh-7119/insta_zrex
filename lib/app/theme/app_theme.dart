import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors/app_colors.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.instagramBlue,
      colorScheme: const ColorScheme.light(
        primary: AppColors.instagramBlue,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: AppColors.lightIcon),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBackground,
        selectedItemColor: AppColors.lightIcon,
        unselectedItemColor: AppColors.lightIcon,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      dividerColor: AppColors.lightDivider,
      textTheme: _textTheme(AppColors.lightText, AppColors.lightSubText),
      iconTheme: const IconThemeData(color: AppColors.lightIcon),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.instagramBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.instagramBlue,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: AppColors.darkIcon),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: AppColors.darkIcon,
        unselectedItemColor: AppColors.darkIcon,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      dividerColor: AppColors.darkDivider,
      textTheme: _textTheme(AppColors.darkText, AppColors.darkSubText),
      iconTheme: const IconThemeData(color: AppColors.darkIcon),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: AppConstants.fontSizeL,
        fontWeight: AppConstants.fontWeightNormal,
        color: primary,
      ),
      bodyMedium: TextStyle(
        fontSize: AppConstants.fontSizeM,
        fontWeight: AppConstants.fontWeightNormal,
        color: primary,
      ),
      bodySmall: TextStyle(
        fontSize: AppConstants.fontSizeS,
        fontWeight: AppConstants.fontWeightNormal,
        color: secondary,
      ),
      labelSmall: TextStyle(
        fontSize: AppConstants.fontSizeXS,
        fontWeight: AppConstants.fontWeightNormal,
        color: secondary,
      ),
      titleMedium: TextStyle(
        fontSize: AppConstants.fontSizeL,
        fontWeight: AppConstants.fontWeightSemiBold,
        color: primary,
      ),
      titleSmall: TextStyle(
        fontSize: AppConstants.fontSizeM,
        fontWeight: AppConstants.fontWeightSemiBold,
        color: primary,
      ),
    );
  }
}
