import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/widgets/custom_video_player.dart';
import '../../../core/constants/app_colors.dart';

/// Video header for series details - shows trailer or episode
class SeriesVideoHeader extends StatelessWidget {
  final VideoPlayerController? videoController;
  final String? thumbnailUrl;
  final bool isLoading;
  final String? error;
  final VoidCallback? onPlayTrailer;
  final VoidCallback? onBack;

  const SeriesVideoHeader({
    super.key,
    this.videoController,
    this.thumbnailUrl,
    this.isLoading = false,
    this.error,
    this.onPlayTrailer,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final hasVideo = videoController != null && videoController!.value.isInitialized;
    
    if (hasVideo) {
      return CustomVideoPlayer(
        controller: videoController!,
        onBack: onBack,
      );
    }
    
    // Show thumbnail with play button
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          if (thumbnailUrl != null)
            Image.network(
              thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(Icons.tv, size: 96, color: Colors.white70),
                  ),
                );
              },
            )
          else
            Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(Icons.tv, size: 96, color: Colors.white70),
              ),
            ),
          
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          
          // Back button
          Positioned(
            top: 16,
            left: 16,
            child: Material(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: onBack,
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
          
          // Play button
          if (onPlayTrailer != null)
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPlayTrailer,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldLight.withValues(alpha: 0.9),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldLight.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            ),
                          )
                        : Icon(
                            error != null ? Icons.error_outline : Icons.play_arrow,
                            size: 48,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
