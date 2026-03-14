import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../common/custom_snackbar.dart';

class InstagramAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InstagramAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final iconColor = isDark ? AppColors.darkIcon : AppColors.lightIcon;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        border: Border(
          bottom: BorderSide(color: dividerColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: AppConstants.appBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingM,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Plus / Create icon (left) ──
                _AppBarIconButton(
                  icon: Icons.add,
                  iconSize: 28,
                  onTap: () => CustomSnackbar.show('Create coming soon'),
                  color: iconColor,
                ),
                const Spacer(),
                // ── Instagram Script Logo (center) ──
                Text(
                  'Instagram',
                  style: GoogleFonts.pacifico(
                    fontSize: AppConstants.appBarLogoFontSize,
                    color: textColor,
                    height: 1.0,
                  ),
                ),
                const Spacer(),
                // ── Notification Heart ──
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _AppBarIconButton(
                      icon: Icons.favorite_border,
                      iconSize: 26,
                      onTap: () => CustomSnackbar.show('Notifications coming soon'),
                      color: iconColor,
                    ),
                    // Red dot badge
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.likeRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback onTap;
  final Color color;

  const _AppBarIconButton({
    required this.icon,
    required this.iconSize,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXS),
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
