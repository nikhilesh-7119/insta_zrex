import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../controllers/story_controller.dart';
import '../common/custom_snackbar.dart';
import 'story_item.dart';

class StoriesTray extends StatelessWidget {
  const StoriesTray({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: AppConstants.storiesTrayHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 0.5,
          ),
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmer(isDark);
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingS,
            vertical: AppConstants.paddingS,
          ),
          itemCount: controller.stories.length,
          itemBuilder: (context, index) {
            final story = controller.stories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingXS,
              ),
              child: StoryItem(
                username: story.user.username,
                avatarUrl: story.user.avatarUrl,
                isSeen: story.isSeen,
                isOwn: story.isOwn,
                onTap: () {
                  controller.markSeen(story.id);
                  if (story.isOwn) {
                    CustomSnackbar.show('Add to story coming soon');
                  } else {
                    CustomSnackbar.show('Stories viewer coming soon');
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildShimmer(bool isDark) {
    final baseColor = isDark ? AppColors.darkShimmerBase : AppColors.lightShimmerBase;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingS,
        vertical: AppConstants.paddingS,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingXS),
          child: SizedBox(
            width: AppConstants.storyItemWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: AppConstants.avatarSizeStory + 6,
                  height: AppConstants.avatarSizeStory + 6,
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Container(
                  width: 44,
                  height: 10,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
