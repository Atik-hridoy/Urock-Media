import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../../core/widgets/app_loader.dart';
import '../../home/data/movie_model.dart';
import '../../home/services/movie_service.dart';
import 'related_movie_card.dart';

/// Related movies section with vertical scrolling
class RelatedMoviesSection extends StatefulWidget {
  final String movieId;

  const RelatedMoviesSection({
    super.key,
    required this.movieId,
  });

  @override
  State<RelatedMoviesSection> createState() => _RelatedMoviesSectionState();
}

class _RelatedMoviesSectionState extends State<RelatedMoviesSection> {
  final MovieService _movieService = MovieService();
  List<Movie> _relatedMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedMovies();
  }

  Future<void> _loadRelatedMovies() async {
    setState(() {
      _isLoading = true;
    });

    final movies = await _movieService.getRelatedMovies(widget.movieId);

    setState(() {
      _relatedMovies = movies;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final bool isTv = ResponsiveScale.isTV || ResponsiveScale.isDesktop;
    final int crossAxisCount = isTv ? 6 : 3;
    final double spacing = isTv ? AppSizes.spacingMD : 12;
    final double aspectRatio = isTv ? 0.55 : 0.7;

    return Padding(
      padding: EdgeInsets.all(isTv ? AppSizes.paddingLG : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Related Movies :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: AppLoader(message: 'Loading related movies...'),
              ),
            )
          else if (_relatedMovies.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No related movies found',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
                childAspectRatio: aspectRatio,
              ),
              itemCount: _relatedMovies.length,
              itemBuilder: (context, index) {
                return RelatedMovieCard(movie: _relatedMovies[index]);
              },
            ),
        ],
      ),
    );
  }
}
