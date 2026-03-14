import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../models/post_model.dart';
import '../common/custom_snackbar.dart';
import '../zoom/pinch_zoom_overlay.dart';
import 'carousel_widget.dart';

class PostMedia extends StatefulWidget {
  final PostModel post;
  final VoidCallback onDoubleTap;

  const PostMedia({super.key, required this.post, required this.onDoubleTap});

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia>
    with SingleTickerProviderStateMixin {
  bool _showHeart = false;
  late AnimationController _heartController;
  late Animation<double> _heartAnim;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: AppConstants.likeAnimDuration,
    );
    _heartAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    widget.onDoubleTap();
    setState(() => _showHeart = true);
    _heartController.forward(from: 0).then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          _heartController.reverse().then((_) {
            if (mounted) setState(() => _showHeart = false);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.post.imageUrls.length > 1) {
      return CarouselWidget(
        imageUrls: widget.post.imageUrls,
        onDoubleTap: _handleDoubleTap,
      );
    }

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: AppConstants.postImageAspectRatio,
            child: PinchZoomOverlay(
              child: CachedNetworkImage(
                imageUrl: widget.post.imageUrls.first,
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
                  color: Colors.black.withAlpha(153),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
          // Double-tap heart animation
          if (_showHeart)
            AnimatedBuilder(
              animation: _heartAnim,
              builder: (context, _) => Transform.scale(
                scale: _heartAnim.value,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 90,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
