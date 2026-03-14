import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../controllers/feed_controller.dart';
import '../../models/post_model.dart';
import 'post_actions.dart';
import 'post_caption.dart';
import 'post_header.dart';
import 'post_media.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: avatar + username + audio/location + options
        PostHeader(post: post),

        // Media: image or carousel
        PostMedia(
          post: post,
          onDoubleTap: () => controller.toggleLike(post.id),
        ),

        const SizedBox(height: AppConstants.paddingXS),

        // Actions: like+count, comment+count, share | save
        PostActions(
          post: post,
          onLike: () => controller.toggleLike(post.id),
          onSave: () => controller.toggleSave(post.id),
        ),

        // "Liked by username and others"  +  caption
        PostMeta(post: post),
        const SizedBox(height: AppConstants.paddingXS),
        PostCaption(post: post),
        const SizedBox(height: AppConstants.paddingM),

        // Divider
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ],
    );
  }
}
