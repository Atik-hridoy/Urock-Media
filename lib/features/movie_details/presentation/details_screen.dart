import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/data/movie_model.dart';
import '../widgets/movie_backdrop_header.dart';
import '../widgets/movie_action_buttons.dart';
import '../widgets/movie_overview_section.dart';
import '../widgets/related_movies_section.dart';

/// Movie details screen with comprehensive information
class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isInWatchlist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          MovieBackdropHeader(
            title: widget.movie.title,
            genres: const ['Action', 'Superhero'],
            year: '2025',
            ageRating: '13+',
            duration: '2h 20 m',
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                MovieActionButtons(
                  isInWatchlist: _isInWatchlist,
                  onWatchNow: _handleWatchNow,
                  onWatchlistToggle: _handleWatchlistToggle,
                  onInviteFriends: _handleInviteFriends,
                  onShare: _handleShare,
                ),
                MovieOverviewSection(movie: widget.movie),
                const RelatedMoviesSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleWatchNow() {
    // TODO: Implement watch functionality
  }

  void _handleWatchlistToggle() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _handleInviteFriends() {
    // TODO: Implement invite functionality
  }

  void _handleShare() {
    // TODO: Implement share functionality
  }
}
