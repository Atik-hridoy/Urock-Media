import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/widgets/app_loader.dart';
import 'movie_poster_card.dart';

/// Recommended series section widget
class RecommendedSeriesSection extends StatefulWidget {
  const RecommendedSeriesSection({super.key});

  @override
  State<RecommendedSeriesSection> createState() => _RecommendedSeriesSectionState();
}

class _RecommendedSeriesSectionState extends State<RecommendedSeriesSection> {
  final MovieService _movieService = MovieService();
  List<Movie> _recommendedSeries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendedSeries();
  }

  Future<void> _loadRecommendedSeries() async {
    setState(() {
      _isLoading = true;
    });

    final series = await _movieService.getRecommendedSeries();

    if (mounted) {
      setState(() {
        _recommendedSeries = series;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: AppLoader(message: 'Loading recommended series...'),
        ),
      );
    }

    if (_recommendedSeries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // const Icon(
              //   Icons.recommend,
              //   color: Colors.amber,
              //   size: 20,
              // ),
              const SizedBox(width: 8),
              Text(
                'Recommended for You',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _recommendedSeries.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < _recommendedSeries.length - 1 ? 12 : 0,
                ),
                child: MoviePosterCard(
                  movie: _recommendedSeries[index],
                  isSeries: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
