import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../constants/app_colors.dart';

/// Custom video player with YouTube-like controls
class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String? title;
  final VoidCallback? onBack;
  final bool showBackButton;
  final bool isFullscreenMode; // Track if we're in fullscreen

  const CustomVideoPlayer({
    super.key,
    required this.controller,
    this.title,
    this.onBack,
    this.showBackButton = true,
    this.isFullscreenMode = false,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool _showControls = true;
  Timer? _hideControlsTimer;
  double _playbackSpeed = 1.0;
  bool _showSpeedMenu = false;
  String? _seekFeedback; // For showing +10s / -10s feedback
  Timer? _seekFeedbackTimer;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_videoListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoListener);
    _hideControlsTimer?.cancel();
    _seekFeedbackTimer?.cancel();
    // Reset orientation when disposing only if we're in fullscreen
    if (_isFullscreen) {
      // Don't await here to avoid delays
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    super.dispose();
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    if (!mounted) return;
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && widget.controller.value.isPlaying) {
        setState(() {
          _showControls = false;
          _showSpeedMenu = false;
        });
      }
    });
  }

  void _toggleControls() {
    if (!mounted) return;
    setState(() {
      _showControls = !_showControls;
      if (!_showControls) {
        _showSpeedMenu = false;
      }
    });
    if (_showControls && widget.controller.value.isPlaying) {
      _startHideControlsTimer();
    }
  }

  void _togglePlayPause() {
    if (!mounted) return;
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      _hideControlsTimer?.cancel();
      setState(() {
        _showControls = true;
      });
    } else {
      widget.controller.play();
      _startHideControlsTimer();
    }
  }

  void _seek(Duration duration) {
    if (!mounted) return;
    final currentPosition = widget.controller.value.position;
    final newPosition = currentPosition + duration;
    
    // Clamp between 0 and video duration
    Duration clampedPosition;
    if (newPosition < Duration.zero) {
      clampedPosition = Duration.zero;
    } else if (newPosition > widget.controller.value.duration) {
      clampedPosition = widget.controller.value.duration;
    } else {
      clampedPosition = newPosition;
    }
    
    widget.controller.seekTo(clampedPosition);
    
    // Show seek feedback
    setState(() {
      _seekFeedback = duration.isNegative ? '-${duration.inSeconds.abs()}s' : '+${duration.inSeconds}s';
    });
    _seekFeedbackTimer?.cancel();
    _seekFeedbackTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _seekFeedback = null;
        });
      }
    });
  }

  void _changePlaybackSpeed(double speed) {
    if (!mounted) return;
    setState(() {
      _playbackSpeed = speed;
      _showSpeedMenu = false;
    });
    widget.controller.setPlaybackSpeed(speed);
  }

  Future<void> _toggleFullscreen() async {
    if (_isFullscreen) {
      await _exitFullscreen();
    } else {
      await _enterFullscreen();
    }
  }

  Future<void> _enterFullscreen() async {
    // Navigate to fullscreen page
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) => _FullscreenVideoPlayer(
          controller: widget.controller,
          title: widget.title,
          playbackSpeed: _playbackSpeed,
          onExit: () {
            Navigator.of(context).pop();
          },
          onSpeedChange: (speed) {
            setState(() {
              _playbackSpeed = speed;
            });
            widget.controller.setPlaybackSpeed(speed);
          },
        ),
      ),
    );
    
    // Reset orientation after exiting fullscreen
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _exitFullscreen() async {
    // This won't be called anymore since we use Navigator
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    if (mounted) {
      setState(() {
        _isFullscreen = false;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      onDoubleTapDown: (details) {
        final screenWidth = MediaQuery.of(context).size.width;
        final tapPosition = details.globalPosition.dx;
        
        if (tapPosition < screenWidth / 3) {
          _seek(const Duration(seconds: -10));
        } else if (tapPosition > screenWidth * 2 / 3) {
          _seek(const Duration(seconds: 10));
        }
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(child: VideoPlayer(widget.controller)),
              
              if (_showControls)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              
              if (_seekFeedback != null)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _seekFeedback!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              if (_showControls) _buildVideoControls(),
              
              // Center play/pause button (perfectly centered)
              if (_showControls)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      child: IconButton(
                        onPressed: _togglePlayPause,
                        icon: Icon(
                          widget.controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 48,
                        ),
                        iconSize: 48,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
              
              if (widget.showBackButton && _showControls)
                Positioned(
                  top: 16,
                  left: 16,
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: widget.onBack,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              
              if (_showSpeedMenu)
                Positioned(
                  right: 16,
                  bottom: 80,
                  child: _buildSpeedMenu(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedMenu() {
    final speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: speeds.map((speed) {
          final isSelected = _playbackSpeed == speed;
          return InkWell(
            onTap: () => _changePlaybackSpeed(speed),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.goldLight.withValues(alpha: 0.2) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    const Icon(Icons.check, color: AppColors.goldLight, size: 16),
                  if (isSelected)
                    const SizedBox(width: 8),
                  Text(
                    '${speed}x',
                    style: TextStyle(
                      color: isSelected ? AppColors.goldLight : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top bar with title
        if (widget.title != null)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 4,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else
          const SizedBox.shrink(),
        
        // Bottom controls
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: _isFullscreen ? 4 : 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress bar
              VideoProgressIndicator(
                widget.controller,
                allowScrubbing: true,
                padding: EdgeInsets.symmetric(vertical: _isFullscreen ? 4 : 8),
                colors: VideoProgressColors(
                  playedColor: AppColors.goldLight,
                  bufferedColor: Colors.white.withValues(alpha: 0.3),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              // Time and controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Current time / Duration
                  Text(
                    '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _isFullscreen ? 12 : 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Controls
                  Row(
                    children: [
                      // Playback speed
                      IconButton(
                        onPressed: () {
                          if (!mounted) return;
                          setState(() {
                            _showSpeedMenu = !_showSpeedMenu;
                          });
                        },
                        icon: Text(
                          '${_playbackSpeed}x',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _isFullscreen ? 12 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.all(_isFullscreen ? 4 : 8),
                        constraints: const BoxConstraints(),
                      ),
                      // Volume
                      IconButton(
                        onPressed: () {
                          if (!mounted) return;
                          setState(() {
                            widget.controller.setVolume(
                              widget.controller.value.volume > 0 ? 0 : 1,
                            );
                          });
                        },
                        icon: Icon(
                          widget.controller.value.volume > 0
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                          size: _isFullscreen ? 20 : 24,
                        ),
                        padding: EdgeInsets.all(_isFullscreen ? 4 : 8),
                        constraints: const BoxConstraints(),
                      ),
                      // Fullscreen
                      IconButton(
                        onPressed: _toggleFullscreen,
                        icon: Icon(
                          _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          color: Colors.white,
                          size: _isFullscreen ? 20 : 24,
                        ),
                        padding: EdgeInsets.all(_isFullscreen ? 4 : 8),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


/// Fullscreen video player widget
class _FullscreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String? title;
  final double playbackSpeed;
  final VoidCallback onExit;
  final Function(double) onSpeedChange;

  const _FullscreenVideoPlayer({
    required this.controller,
    this.title,
    required this.playbackSpeed,
    required this.onExit,
    required this.onSpeedChange,
  });

  @override
  State<_FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<_FullscreenVideoPlayer> {
  bool _showControls = true;
  Timer? _hideControlsTimer;
  double _playbackSpeed = 1.0;
  bool _showSpeedMenu = false;
  String? _seekFeedback;
  Timer? _seekFeedbackTimer;

  @override
  void initState() {
    super.initState();
    _playbackSpeed = widget.playbackSpeed;
    widget.controller.addListener(_videoListener);
    _enterFullscreen();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoListener);
    _hideControlsTimer?.cancel();
    _seekFeedbackTimer?.cancel();
    _exitFullscreen();
    super.dispose();
  }

  Future<void> _enterFullscreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _exitFullscreen() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    if (!mounted) return;
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && widget.controller.value.isPlaying) {
        setState(() {
          _showControls = false;
          _showSpeedMenu = false;
        });
      }
    });
  }

  void _toggleControls() {
    if (!mounted) return;
    setState(() {
      _showControls = !_showControls;
      if (!_showControls) {
        _showSpeedMenu = false;
      }
    });
    if (_showControls && widget.controller.value.isPlaying) {
      _startHideControlsTimer();
    }
  }

  void _togglePlayPause() {
    if (!mounted) return;
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      _hideControlsTimer?.cancel();
      setState(() {
        _showControls = true;
      });
    } else {
      widget.controller.play();
      _startHideControlsTimer();
    }
  }

  void _seek(Duration duration) {
    if (!mounted) return;
    final currentPosition = widget.controller.value.position;
    final newPosition = currentPosition + duration;
    
    Duration clampedPosition;
    if (newPosition < Duration.zero) {
      clampedPosition = Duration.zero;
    } else if (newPosition > widget.controller.value.duration) {
      clampedPosition = widget.controller.value.duration;
    } else {
      clampedPosition = newPosition;
    }
    
    widget.controller.seekTo(clampedPosition);
    
    setState(() {
      _seekFeedback = duration.isNegative ? '-${duration.inSeconds.abs()}s' : '+${duration.inSeconds}s';
    });
    _seekFeedbackTimer?.cancel();
    _seekFeedbackTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _seekFeedback = null;
        });
      }
    });
  }

  void _changePlaybackSpeed(double speed) {
    if (!mounted) return;
    setState(() {
      _playbackSpeed = speed;
      _showSpeedMenu = false;
    });
    widget.controller.setPlaybackSpeed(speed);
    widget.onSpeedChange(speed);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        onDoubleTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.globalPosition.dx;
          
          if (tapPosition < screenWidth / 3) {
            _seek(const Duration(seconds: -10));
          } else if (tapPosition > screenWidth * 2 / 3) {
            _seek(const Duration(seconds: 10));
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(child: VideoPlayer(widget.controller)),
            
            if (_showControls)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            
            if (_seekFeedback != null)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _seekFeedback!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            if (_showControls) _buildVideoControls(),
            
            // Center play/pause button (perfectly centered)
            if (_showControls)
              Positioned.fill(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: IconButton(
                      onPressed: _togglePlayPause,
                      icon: Icon(
                        widget.controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 48,
                      ),
                      iconSize: 48,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
              ),
            
            if (_showControls)
              Positioned(
                top: 16,
                left: 16,
                child: Material(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: widget.onExit,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.fullscreen_exit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            
            if (_showSpeedMenu)
              Positioned(
                right: 16,
                bottom: 80,
                child: _buildSpeedMenu(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedMenu() {
    final speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: speeds.map((speed) {
          final isSelected = _playbackSpeed == speed;
          return InkWell(
            onTap: () => _changePlaybackSpeed(speed),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.goldLight.withValues(alpha: 0.2) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    const Icon(Icons.check, color: AppColors.goldLight, size: 16),
                  if (isSelected)
                    const SizedBox(width: 8),
                  Text(
                    '${speed}x',
                    style: TextStyle(
                      color: isSelected ? AppColors.goldLight : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title != null)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 4,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else
          const SizedBox.shrink(),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoProgressIndicator(
                widget.controller,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(vertical: 4),
                colors: VideoProgressColors(
                  playedColor: AppColors.goldLight,
                  bufferedColor: Colors.white.withValues(alpha: 0.3),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (!mounted) return;
                          setState(() {
                            _showSpeedMenu = !_showSpeedMenu;
                          });
                        },
                        icon: Text(
                          '${_playbackSpeed}x',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!mounted) return;
                          setState(() {
                            widget.controller.setVolume(
                              widget.controller.value.volume > 0 ? 0 : 1,
                            );
                          });
                        },
                        icon: Icon(
                          widget.controller.value.volume > 0
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: widget.onExit,
                        icon: const Icon(
                          Icons.fullscreen_exit,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
