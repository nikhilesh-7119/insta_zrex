import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../common/custom_snackbar.dart';
import '../zoom/pinch_zoom_overlay.dart';
import 'dot_indicator.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback onDoubleTap;

  const CarouselWidget({
    super.key,
    required this.imageUrls,
    required this.onDoubleTap,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: AppConstants.postImageAspectRatio,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: widget.onDoubleTap,
                child: PinchZoomOverlay(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: isDark
                          ? AppColors.darkShimmerBase
                          : AppColors.lightShimmerBase,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: isDark
                          ? AppColors.darkShimmerBase
                          : AppColors.lightShimmerBase,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Mute button — bottom-right inside image
        Positioned(
          bottom: AppConstants.paddingM,
          right: AppConstants.paddingM,
          child: GestureDetector(
            onTap: () => CustomSnackbar.show('Sound coming soon'),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.muteButtonBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up,
                color: AppColors.iconOnDark,
                size: 16,
              ),
            ),
          ),
        ),
        // Dot indicators — bottom-center, inside the image
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: AppConstants.paddingS,
            child: DotIndicator(
              count: widget.imageUrls.length,
              currentIndex: _currentIndex,
            ),
          ),
      ],
    );
  }
}
