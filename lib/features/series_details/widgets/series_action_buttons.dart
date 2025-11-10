import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Series action buttons section
class SeriesActionButtons extends StatelessWidget {
  final bool isInWatchlist;
  final VoidCallback onWatchNow;
  final VoidCallback onWatchlistToggle;
  final VoidCallback onInviteFriends;
  final VoidCallback onShare;

  const SeriesActionButtons({
    super.key,
    required this.isInWatchlist,
    required this.onWatchNow,
    required this.onWatchlistToggle,
    required this.onInviteFriends,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Watch Now Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onWatchNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldLight,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_outline, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Watch Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Action Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: isInWatchlist ? Icons.check : Icons.add,
                label: 'Watchlist',
                onTap: onWatchlistToggle,
              ),
              _buildActionButton(
                icon: Icons.person_add_outlined,
                label: 'Invite Friends',
                onTap: onInviteFriends,
              ),
              _buildActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: onShare,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
