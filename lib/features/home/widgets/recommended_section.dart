import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/widgets/app_loader.dart';
import 'movie_poster_card.dart';

/// Recommended movies section widget
class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key});

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  final MovieService _movieService = MovieService();
  List<Movie> _recommendedMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendedMovies();
  }

  Future<void> _loadRecommendedMovies() async {
    setState(() {
      _isLoading = true;
    });

    final movies = await _movieService.getRecommendedMovies();

    if (mounted) {
      setState(() {
        _recommendedMovies = movies;
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
          child: AppLoader(message: 'Loading recommendations...'),
        ),
      );
    }

    if (_recommendedMovies.isEmpty) {
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
            itemCount: _recommendedMovies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < _recommendedMovies.length - 1 ? 12 : 0,
                ),
                child: MoviePosterCard(
                  movie: _recommendedMovies[index],
                  isSeries: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
