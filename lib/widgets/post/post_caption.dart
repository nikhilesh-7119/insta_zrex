import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../models/post_model.dart';
import '../common/custom_snackbar.dart';

class PostCaption extends StatefulWidget {
  final PostModel post;

  const PostCaption({super.key, required this.post});

  @override
  State<PostCaption> createState() => _PostCaptionState();
}

class _PostCaptionState extends State<PostCaption> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor = isDark ? AppColors.darkSubText : AppColors.lightSubText;

    final caption = widget.post.caption;
    const maxChars = 100;
    final isLong = caption.length > maxChars;
    final displayText =
        (!_expanded && isLong) ? '${caption.substring(0, maxChars)}...' : caption;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: AppConstants.fontSizeM,
            color: textColor,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: widget.post.user.username,
              style: TextStyle(
                fontWeight: AppConstants.fontWeightSemiBold,
                color: textColor,
              ),
            ),
            const TextSpan(text: '  '),
            TextSpan(text: displayText),
            if (isLong && !_expanded)
              TextSpan(
                text: ' more',
                style: TextStyle(
                  color: subColor,
                  fontWeight: AppConstants.fontWeightMedium,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => setState(() => _expanded = true),
              ),
          ],
        ),
      ),
    );
  }
}

class PostMeta extends StatelessWidget {
  final PostModel post;

  const PostMeta({super.key, required this.post});

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      final formatted = count.toString();
      if (formatted.length > 3) {
        return '${formatted.substring(0, formatted.length - 3)},${formatted.substring(formatted.length - 3)}';
      }
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor = isDark ? AppColors.darkSubText : AppColors.lightSubText;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Likes count
          Text(
            '${_formatCount(post.likesCount)} likes',
            style: TextStyle(
              fontSize: AppConstants.fontSizeM,
              fontWeight: AppConstants.fontWeightSemiBold,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingXS),
          // View all comments
          if (post.commentsCount > 0)
            GestureDetector(
              onTap: () => CustomSnackbar.show('Comments coming soon'),
              child: Text(
                'View all ${_formatCount(post.commentsCount)} comments',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeM,
                  color: subColor,
                ),
              ),
            ),
          const SizedBox(height: AppConstants.paddingXS),
          // Timestamp
          Text(
            post.timeAgo.toUpperCase(),
            style: TextStyle(
              fontSize: AppConstants.fontSizeXS,
              color: subColor,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
