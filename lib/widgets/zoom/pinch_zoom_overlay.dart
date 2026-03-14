import 'package:flutter/material.dart';
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
  late Animation<double> _scaleAnim;
  late Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: AppConstants.zoomAnimDuration,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _bgAnim = Tween<double>(begin: 0.0, end: 0.85).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animController.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay();

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => _ZoomOverlayContent(
        imageWidget: widget.child,
        initialOffset: offset,
        imageSize: size,
        scaleAnim: _scaleAnim,
        bgAnim: _bgAnim,
        onClose: _closeOverlay,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _bgAnim = Tween<double>(begin: 0.0, end: 0.85).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward(from: 0);
    _overlayEntry!.markNeedsBuild();
  }

  void _closeOverlay() {
    _animController.reverse().then((_) => _removeOverlay());
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (_) => _showOverlay(context),
      child: widget.child,
    );
  }
}

class _ZoomOverlayContent extends StatefulWidget {
  final Widget imageWidget;
  final Offset initialOffset;
  final Size imageSize;
  final Animation<double> scaleAnim;
  final Animation<double> bgAnim;
  final VoidCallback onClose;

  const _ZoomOverlayContent({
    required this.imageWidget,
    required this.initialOffset,
    required this.imageSize,
    required this.scaleAnim,
    required this.bgAnim,
    required this.onClose,
  });

  @override
  State<_ZoomOverlayContent> createState() => _ZoomOverlayContentState();
}

class _ZoomOverlayContentState extends State<_ZoomOverlayContent>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset _startFocalPoint = Offset.zero;
  Offset _startOffset = Offset.zero;

  late AnimationController _returnController;
  late Animation<double> _returnScaleAnim;
  late Animation<Offset> _returnOffsetAnim;

  @override
  void initState() {
    super.initState();
    _returnController = AnimationController(
      vsync: this,
      duration: AppConstants.zoomAnimDuration,
    );
    _returnScaleAnim = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _returnController, curve: Curves.easeOut),
    );
    _returnOffsetAnim = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _returnController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _returnController.dispose();
    super.dispose();
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startFocalPoint = details.focalPoint;
    _startOffset = _offset;
    _returnController.stop();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_scale * details.scale).clamp(0.5, 6.0);
      final delta = details.focalPoint - _startFocalPoint;
      _offset = _startOffset + delta;
      _startFocalPoint = details.focalPoint;
      _startOffset = _offset;
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (_scale <= 1.05) {
      widget.onClose();
      return;
    }
    // Animate back to center
    _returnScaleAnim = Tween<double>(begin: _scale, end: 1.0).animate(
      CurvedAnimation(parent: _returnController, curve: Curves.easeOut),
    );
    _returnOffsetAnim = Tween<Offset>(
      begin: _offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _returnController, curve: Curves.easeOut),
    );
    _returnController.forward(from: 0).then((_) {
      setState(() {
        _scale = 1.0;
        _offset = Offset.zero;
      });
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_returnController]),
      builder: (context, child) {
        final currentScale =
            _returnController.isAnimating ? _returnScaleAnim.value : _scale;
        final currentOffset = _returnController.isAnimating
            ? _returnOffsetAnim.value
            : _offset;

        return Stack(
          children: [
            // Background overlay
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.onClose,
                child: Container(color: Colors.black.withAlpha(217)),
              ),
            ),
            // Zoomed image
            Positioned(
              left: widget.initialOffset.dx + currentOffset.dx,
              top: widget.initialOffset.dy + currentOffset.dy,
              width: widget.imageSize.width,
              height: widget.imageSize.height,
              child: GestureDetector(
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                onScaleEnd: _onScaleEnd,
                child: Transform.scale(
                  scale: currentScale,
                  child: widget.imageWidget,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
