import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';

/// TV-optimized live TV player popup
class TvPlayerPopup extends StatefulWidget {
  final String channelName;
  final String channelLogo;

  const TvPlayerPopup({
    super.key,
    required this.channelName,
    required this.channelLogo,
  });

  @override
  State<TvPlayerPopup> createState() => _TvPlayerPopupState();
}

class _TvPlayerPopupState extends State<TvPlayerPopup> {
  final FocusNode _mainFocusNode = FocusNode();
  final FocusNode _controlsFocusNode = FocusNode();
  bool _isPlaying = true;
  bool _showControls = true;
  double _volume = 0.8;

  @override
  void initState() {
    super.initState();
    // Hide controls after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _mainFocusNode.dispose();
    _controlsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(1200.0, 1600.0);

    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.all(AppSizes.paddingXL),
      child: KeyboardListener(
        focusNode: _mainFocusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Container(
          width: double.infinity,
          height: ResponsiveScale.height(600),
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: ResponsiveScale.height(700),
          ),
          child: Stack(
            children: [
              // Video Player Background
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                ),
                child: Stack(
                  children: [
                    // Mock Video Player
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ResponsiveScale.width(120),
                              height: ResponsiveScale.height(120),
                              decoration: BoxDecoration(
                                color: AppColors.goldLight.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.goldLight,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.channelLogo,
                                  style: TextStyle(
                                    color: AppColors.goldLight,
                                    fontSize: ResponsiveScale.fontSize(32),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingLG),
                            Text(
                              widget.channelName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveScale.fontSize(24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingMD),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: ResponsiveScale.fontSize(18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Play/Pause Indicator
                    if (!_isPlaying)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: ResponsiveScale.iconSize(80),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Controls Overlay
              if (_showControls)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    ),
                    child: Column(
                      children: [
                        // Top Bar
                        _buildTopBar(),
                        const Spacer(),
                        // Bottom Controls
                        _buildBottomControls(),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Row(
        children: [
          // Channel Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.channelName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveScale.fontSize(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'LIVE • ${_getCurrentTime()}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ResponsiveScale.fontSize(14),
                  ),
                ),
              ],
            ),
          ),
          // Close Button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: ResponsiveScale.width(40),
              height: ResponsiveScale.height(40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: ResponsiveScale.iconSize(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Row(
        children: [
          // Play/Pause Button
          GestureDetector(
            onTap: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: Container(
              width: ResponsiveScale.width(50),
              height: ResponsiveScale.height(50),
              decoration: BoxDecoration(
                color: AppColors.goldLight.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.goldLight,
                  width: 2,
                ),
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.goldLight,
                size: ResponsiveScale.iconSize(24),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingLG),
          // Volume Control
          Expanded(
            child: SizedBox(
              height: ResponsiveScale.height(40),
              child: Row(
                children: [
                  Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: ResponsiveScale.iconSize(20),
                  ),
                  const SizedBox(width: AppSizes.spacingMD),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _volume,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.goldLight,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingLG),
          // Fullscreen Button
          GestureDetector(
            onTap: () {
              // TODO: Implement fullscreen
            },
            child: Container(
              width: ResponsiveScale.width(40),
              height: ResponsiveScale.height(40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.fullscreen,
                color: Colors.white,
                size: ResponsiveScale.iconSize(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.escape:
          Navigator.of(context).pop();
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.select:
        case LogicalKeyboardKey.space:
          setState(() {
            _isPlaying = !_isPlaying;
          });
          break;
        case LogicalKeyboardKey.arrowLeft:
          setState(() {
            _volume = (_volume - 0.1).clamp(0.0, 1.0);
          });
          break;
        case LogicalKeyboardKey.arrowRight:
          setState(() {
            _volume = (_volume + 0.1).clamp(0.0, 1.0);
          });
          break;
        case LogicalKeyboardKey.arrowUp:
        case LogicalKeyboardKey.arrowDown:
          setState(() {
            _showControls = !_showControls;
          });
          break;
      }
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
