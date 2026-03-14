import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const DotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive
              ? AppConstants.dotSizeActive
              : AppConstants.dotSizeInactive,
          height: isActive
              ? AppConstants.dotSizeActive
              : AppConstants.dotSizeInactive,
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.dotSpacing / 2,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.instagramBlue
                : Colors.grey.withAlpha(153),
          ),
        );
      }),
    );
  }
}
