import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../models/post_model.dart';
import '../common/custom_snackbar.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subTextColor = isDark ? AppColors.darkSubText : AppColors.lightSubText;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
        vertical: AppConstants.paddingS,
      ),
      child: Row(
        children: [
          // Avatar
          _buildAvatar(isDark),
          const SizedBox(width: AppConstants.paddingS),
          // Username + location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      post.user.username,
                      style: TextStyle(
                        fontSize: AppConstants.fontSizeL,
                        fontWeight: AppConstants.fontWeightSemiBold,
                        color: textColor,
                      ),
                    ),
                    if (post.user.isVerified) ...[
                      const SizedBox(width: AppConstants.paddingXS),
                      const Icon(
                        Icons.verified,
                        size: 14,
                        color: AppColors.verifiedBlue,
                      ),
                    ],
                  ],
                ),
                if (post.location != null && post.location!.isNotEmpty)
                  Text(
                    post.location!,
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeXS,
                      color: subTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          // Follow button (for non-following users)
          if (!post.user.isFollowing) ...[
            GestureDetector(
              onTap: () => CustomSnackbar.show('Follow feature coming soon'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingM,
                  vertical: AppConstants.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: AppColors.followButtonBg,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusS),
                ),
                child: const Text(
                  'Follow',
                  style: TextStyle(
                    color: AppColors.followButtonText,
                    fontSize: AppConstants.fontSizeS,
                    fontWeight: AppConstants.fontWeightSemiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingS),
          ],
          // Options menu
          GestureDetector(
            onTap: () => CustomSnackbar.show('Post options coming soon'),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingXS),
              child: Icon(
                Icons.more_horiz,
                size: 22,
                color: isDark ? AppColors.darkIcon : AppColors.lightIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    return Container(
      width: AppConstants.avatarSizePost + 6,
      height: AppConstants.avatarSizePost + 6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: AppColors.storyRingGradient,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      padding: const EdgeInsets.all(1.5),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: post.user.avatarUrl,
          width: AppConstants.avatarSizePost,
          height: AppConstants.avatarSizePost,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey.shade300,
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.grey, size: 16),
          ),
        ),
      ),
    );
  }
}
