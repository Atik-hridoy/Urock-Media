import 'package:flutter/material.dart';
import 'watch_now_button.dart';
import 'action_icon_button.dart';

/// Movie action buttons section (Watch Now + action icons)
class MovieActionButtons extends StatelessWidget {
  final bool isInWatchlist;
  final VoidCallback onWatchNow;
  final VoidCallback onWatchlistToggle;
  final VoidCallback onInviteFriends;
  final VoidCallback onShare;

  const MovieActionButtons({
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          WatchNowButton(onPressed: onWatchNow),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionIconButton(
                icon: isInWatchlist ? Icons.check : Icons.add,
                label: 'Watchlist',
                onTap: onWatchlistToggle,
              ),
              ActionIconButton(
                icon: Icons.person_add_outlined,
                label: 'Invite Friends',
                onTap: onInviteFriends,
              ),
              ActionIconButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
