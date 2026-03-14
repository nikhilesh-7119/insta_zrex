import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static void show(String message) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      messageText: Text(
        message,
        style: const TextStyle(
          color: AppColors.snackbarText,
          fontSize: AppConstants.fontSizeM,
          fontWeight: AppConstants.fontWeightMedium,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: AppConstants.snackbarDuration,
      backgroundColor: AppColors.snackbarBg,
      borderRadius: AppConstants.radiusM,
      margin: const EdgeInsets.all(AppConstants.paddingM),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingL,
        vertical: AppConstants.paddingM,
      ),
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
