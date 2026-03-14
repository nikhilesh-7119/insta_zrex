import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class ComingSoonScreen extends StatelessWidget {
  final String label;
  final IconData icon;

  const ComingSoonScreen({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor = isDark ? AppColors.darkSubText : AppColors.lightSubText;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: subColor,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: AppConstants.fontSizeXXL,
                fontWeight: AppConstants.fontWeightSemiBold,
                color: textColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              '$label is not yet available',
              style: TextStyle(
                fontSize: AppConstants.fontSizeM,
                color: subColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
