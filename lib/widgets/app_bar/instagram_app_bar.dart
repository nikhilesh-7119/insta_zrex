import 'package:flutter/material.dart';
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
              horizontal: AppConstants.paddingL,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Instagram Logo ──
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: AppColors.instagramGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Instagram',
                    style: TextStyle(
                      fontSize: AppConstants.appBarLogoFontSize,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      height: 1.0,
                    ),
                  ),
                ),
                const Spacer(),
                // ── Notification Bell ──
                _AppBarIconButton(
                  icon: Icons.favorite_border_rounded,
                  onTap: () => CustomSnackbar.show('Notifications coming soon'),
                  isDark: isDark,
                ),
                const SizedBox(width: AppConstants.paddingS),
                // ── DM Paper Plane ──
                _AppBarIconButton(
                  icon: Icons.send_outlined,
                  onTap: () => CustomSnackbar.show('Messages coming soon'),
                  isDark: isDark,
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
  final VoidCallback onTap;
  final bool isDark;

  const _AppBarIconButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
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
          size: 26,
          color: isDark ? AppColors.darkIcon : AppColors.lightIcon,
        ),
      ),
    );
  }
}
