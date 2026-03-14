import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../models/post_model.dart';

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

class LikesCount extends StatelessWidget {
  final int likesCount;

  const LikesCount({super.key, required this.likesCount});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: Text(
        '$likesCount likes',
        style: TextStyle(
          fontSize: AppConstants.fontSizeM,
          fontWeight: AppConstants.fontWeightBold,
          color: textColor,
        ),
      ),
    );
  }
}
