import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/data/movie_model.dart';
import '../widgets/series_backdrop_header.dart';
import '../widgets/series_info_section.dart';
import '../widgets/series_action_buttons.dart';
import '../widgets/series_overview_section.dart';
import '../widgets/episodes_section.dart';

/// Series details screen
class SeriesDetailsScreen extends StatefulWidget {
  final Movie series;

  const SeriesDetailsScreen({
    super.key,
    required this.series,
  });

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  bool _isInWatchlist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SeriesBackdropHeader(
            series: widget.series,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SeriesInfoSection(
                  title: widget.series.title,
                  genres: const ['Action', 'Superhero'],
                  year: '2020',
                  ageRating: '16+',
                  seasons: '5 Seasons',
                ),
                const SizedBox(height: 16),
                SeriesActionButtons(
                  isInWatchlist: _isInWatchlist,
                  onWatchNow: _handleWatchNow,
                  onWatchlistToggle: _handleWatchlistToggle,
                  onInviteFriends: _handleInviteFriends,
                  onShare: _handleShare,
                ),
                SeriesOverviewSection(series: widget.series),
                const EpisodesSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleWatchNow() {
    // TODO: Implement watch now functionality
  }

  void _handleWatchlistToggle() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _handleInviteFriends() {
    // TODO: Implement invite friends functionality
  }

  void _handleShare() {
    // TODO: Implement share functionality
  }
}
