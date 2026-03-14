import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
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
                          color: AppColors.lightShimmerBase,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.lightShimmerBase,
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
            // Dot indicator — top right (Instagram style)
            if (widget.imageUrls.length > 1)
              Positioned(
                top: AppConstants.paddingM,
                right: AppConstants.paddingM,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingS,
                    vertical: AppConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusCircle,
                    ),
                  ),
                  child: Text(
                    '${_currentIndex + 1}/${widget.imageUrls.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.fontSizeS,
                      fontWeight: AppConstants.fontWeightMedium,
                    ),
                  ),
                ),
              ),
          ],
        ),
        // Bottom dot indicator
        if (widget.imageUrls.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: AppConstants.paddingS),
            child: DotIndicator(
              count: widget.imageUrls.length,
              currentIndex: _currentIndex,
            ),
          ),
      ],
    );
  }
}
