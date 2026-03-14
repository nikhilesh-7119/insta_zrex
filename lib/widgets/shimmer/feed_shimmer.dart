import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class FeedShimmer extends StatelessWidget {
  const FeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor:
            isDark ? AppColors.darkShimmerBase : AppColors.lightShimmerBase,
        highlightColor: isDark
            ? AppColors.darkShimmerHighlight
            : AppColors.lightShimmerHighlight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => _ShimmerPostCard(isDark: isDark),
      ),
    );
  }
}

class _ShimmerPostCard extends StatelessWidget {
  final bool isDark;

  const _ShimmerPostCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final base =
        isDark ? AppColors.darkShimmerBase : AppColors.lightShimmerBase;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          child: Row(
            children: [
              Container(
                width: AppConstants.avatarSizePost + 6,
                height: AppConstants.avatarSizePost + 6,
                decoration: BoxDecoration(
                  color: base,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppConstants.paddingS),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusS),
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingXS),
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusS),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Image placeholder
        AspectRatio(
          aspectRatio: AppConstants.postImageAspectRatio,
          child: Container(color: base),
        ),
        // Actions row
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: base, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppConstants.paddingL),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: base, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppConstants.paddingL),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: base, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
        // Likes + caption lines
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 11,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Container(
                width: double.infinity,
                height: 11,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Container(
                width: 200,
                height: 11,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ],
    );
  }
}
