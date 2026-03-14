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
          // Avatar — plain circle, no gradient ring
          _buildAvatar(isDark),
          const SizedBox(width: AppConstants.paddingS),
          // Username + audio/location subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        post.user.username,
                        style: TextStyle(
                          fontSize: AppConstants.fontSizeL,
                          fontWeight: AppConstants.fontWeightSemiBold,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
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
                // Subtitle: audio info OR location
                _buildSubtitle(subTextColor),
              ],
            ),
          ),
          // Options menu
          GestureDetector(
            onTap: () => CustomSnackbar.show('Post options coming soon'),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingXS),
              child: Icon(
                Icons.more_vert,
                size: 22,
                color: isDark ? AppColors.darkIcon : AppColors.lightIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(Color subTextColor) {
    final hasAudio = post.audioInfo != null && post.audioInfo!.isNotEmpty;
    final hasLocation = post.location != null && post.location!.isNotEmpty;

    if (!hasAudio && !hasLocation) return const SizedBox.shrink();

    if (hasAudio) {
      return Row(
        children: [
          Icon(Icons.music_note, size: 11, color: subTextColor),
          const SizedBox(width: 2),
          Flexible(
            child: Text(
              post.audioInfo!,
              style: TextStyle(
                fontSize: AppConstants.fontSizeXS,
                color: subTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Text(
      post.location!,
      style: TextStyle(
        fontSize: AppConstants.fontSizeXS,
        color: subTextColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAvatar(bool isDark) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: post.user.avatarUrl,
        width: AppConstants.avatarSizePost,
        height: AppConstants.avatarSizePost,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: AppConstants.avatarSizePost,
          height: AppConstants.avatarSizePost,
          color: isDark ? AppColors.darkPlaceholder : AppColors.lightPlaceholder,
        ),
        errorWidget: (context, url, error) => Container(
          width: AppConstants.avatarSizePost,
          height: AppConstants.avatarSizePost,
          color: isDark ? AppColors.darkPlaceholder : AppColors.lightPlaceholder,
          child: const Icon(Icons.person, color: Colors.grey, size: 16),
        ),
      ),
    );
  }
}
