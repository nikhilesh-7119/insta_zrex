import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../models/post_model.dart';
import '../common/custom_snackbar.dart';

class PostActions extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onSave;

  const PostActions({
    super.key,
    required this.post,
    required this.onLike,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.darkActionIcon : AppColors.lightActionIcon;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
        vertical: AppConstants.paddingXS,
      ),
      child: Row(
        children: [
          // Like
          _ActionButton(
            onTap: onLike,
            child: AnimatedSwitcher(
              duration: AppConstants.likeAnimDuration,
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: child,
              ),
              child: Icon(
                post.isLiked ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(post.isLiked),
                size: AppConstants.postActionsIconSize,
                color: post.isLiked ? AppColors.likeRed : iconColor,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.paddingL),
          // Comment
          _ActionButton(
            onTap: () => CustomSnackbar.show('Comments coming soon'),
            child: Icon(
              Icons.chat_bubble_outline,
              size: AppConstants.postActionsIconSize,
              color: iconColor,
            ),
          ),
          const SizedBox(width: AppConstants.paddingL),
          // Share
          _ActionButton(
            onTap: () => CustomSnackbar.show('Share coming soon'),
            child: Icon(
              Icons.send_outlined,
              size: AppConstants.postActionsIconSize,
              color: iconColor,
            ),
          ),
          const Spacer(),
          // Save
          _ActionButton(
            onTap: onSave,
            child: AnimatedSwitcher(
              duration: AppConstants.likeAnimDuration,
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: child,
              ),
              child: Icon(
                post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                key: ValueKey(post.isSaved),
                size: AppConstants.postActionsIconSizeSave,
                color: post.isSaved
                    ? (isDark ? AppColors.darkText : AppColors.lightText)
                    : iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ActionButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXS),
        child: child,
      ),
    );
  }
}
