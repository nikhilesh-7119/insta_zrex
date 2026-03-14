import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class StoryItem extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final bool isSeen;
  final bool isOwn;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.username,
    required this.avatarUrl,
    required this.isSeen,
    required this.isOwn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppConstants.storyItemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRing(isDark),
            const SizedBox(height: AppConstants.paddingXS),
            _buildUsername(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildRing(bool isDark) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: AppConstants.avatarSizeStory + 6,
          height: AppConstants.avatarSizeStory + 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isSeen
                ? null
                : const LinearGradient(
                    colors: AppColors.storyRingGradient,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
            color: isSeen
                ? (isDark
                    ? AppColors.storySeenColorDark
                    : AppColors.storySeenColor)
                : null,
          ),
          padding: const EdgeInsets.all(AppConstants.storyRingWidth + AppConstants.storyRingGap),
          child: _buildAvatar(),
        ),
        if (isOwn)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.instagramBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                  width: 2,
                ),
              ),
              child: const Icon(Icons.add, size: 12, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatar() {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        width: AppConstants.avatarSizeStory,
        height: AppConstants.avatarSizeStory,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: AppConstants.avatarSizeStory,
          height: AppConstants.avatarSizeStory,
          color: Colors.grey.shade300,
        ),
        errorWidget: (context, url, error) => Container(
          width: AppConstants.avatarSizeStory,
          height: AppConstants.avatarSizeStory,
          color: Colors.grey.shade300,
          child: const Icon(Icons.person, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildUsername(BuildContext context, bool isDark) {
    final displayName = isOwn ? 'Your Story' : username;
    return Text(
      displayName,
      style: TextStyle(
        fontSize: AppConstants.fontSizeXS,
        fontWeight: AppConstants.fontWeightNormal,
        color: isDark ? AppColors.darkText : AppColors.lightText,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
