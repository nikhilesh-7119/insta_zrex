import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';

class PinchZoomOverlay extends StatefulWidget {
  final Widget child;

  const PinchZoomOverlay({super.key, required this.child});

  @override
  State<PinchZoomOverlay> createState() => _PinchZoomOverlayState();
}

class _PinchZoomOverlayState extends State<PinchZoomOverlay>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animController;

  double _scale = 1.0;
  double _baseScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _startFocalPoint = Offset.zero;
  Offset _sessionStartOffset = Offset.zero;
  bool _isZooming = false;
  int _pointerCount = 0;

  double _animStartScale = 1.0;
  Offset _animStartOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: AppConstants.zoomAnimDuration,
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animController.dispose();
    super.dispose();
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startFocalPoint = details.focalPoint;
    _baseScale = _scale;
    _sessionStartOffset = _offset;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // Only zoom when two fingers are down
    if (_pointerCount < 2) return;

    final newScale = (_baseScale * details.scale).clamp(1.0, 5.0);

    if (!_isZooming && newScale > 1.02) {
      _isZooming = true;
      _showOverlay();
    }

    if (_isZooming) {
      final delta = details.focalPoint - _startFocalPoint;
      setState(() {
        _scale = newScale;
        _offset = _sessionStartOffset + delta;
      });
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (!_isZooming) return;
    _animateBack();
  }

  void _showOverlay() {
    _removeOverlay();

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => _ZoomOverlayWidget(
        imageWidget: IgnorePointer(child: widget.child),
        imageSize: size,
        initialOffset: position,
        scale: _scale,
        offset: _offset,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _animateBack() {
    _animStartScale = _scale;
    _animStartOffset = _offset;

    _animController.reset();
    _animController.addListener(_animTick);
    _animController.addStatusListener(_animStatus);
    _animController.forward();
  }

  void _animTick() {
    final t = Curves.easeOut.transform(_animController.value);
    setState(() {
      _scale = _animStartScale + (1.0 - _animStartScale) * t;
      _offset = Offset.lerp(_animStartOffset, Offset.zero, t)!;
    });
    _overlayEntry?.markNeedsBuild();
  }

  void _animStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animController.removeListener(_animTick);
      _animController.removeStatusListener(_animStatus);
      _removeOverlay();
      setState(() {
        _scale = 1.0;
        _offset = Offset.zero;
        _isZooming = false;
      });
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pointerCount++,
      onPointerUp: (_) => _pointerCount--,
      onPointerCancel: (_) => _pointerCount--,
      child: RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          _EagerScaleGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<_EagerScaleGestureRecognizer>(
            () => _EagerScaleGestureRecognizer(),
            (_EagerScaleGestureRecognizer instance) {
              instance
                ..onStart = _onScaleStart
                ..onUpdate = _onScaleUpdate
                ..onEnd = _onScaleEnd;
            },
          ),
        },
        child: Opacity(
          opacity: _isZooming ? 0.0 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}

/// A ScaleGestureRecognizer that immediately accepts the gesture in the arena
/// when two or more pointers are down, preventing the parent ScrollView
/// from stealing the pointers.
class _EagerScaleGestureRecognizer extends ScaleGestureRecognizer {
  _EagerScaleGestureRecognizer() : super();

  @override
  void rejectGesture(int pointer) {
    // When we have multiple pointers, force accept instead of reject
    acceptGesture(pointer);
  }
}

class _ZoomOverlayWidget extends StatelessWidget {
  final Widget imageWidget;
  final Size imageSize;
  final Offset initialOffset;
  final double scale;
  final Offset offset;

  const _ZoomOverlayWidget({
    required this.imageWidget,
    required this.imageSize,
    required this.initialOffset,
    required this.scale,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: AppColors.zoomOverlayBg
                  .withValues(alpha: ((scale - 1.0) / 2.0).clamp(0.0, 0.85)),
            ),
          ),
          Positioned(
            left: initialOffset.dx + offset.dx,
            top: initialOffset.dy + offset.dy,
            width: imageSize.width,
            height: imageSize.height,
            child: Transform.scale(
              scale: scale,
              child: imageWidget,
            ),
          ),
        ],
      ),
    );
  }
}
