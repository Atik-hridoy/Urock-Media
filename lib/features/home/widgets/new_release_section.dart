import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/widgets/app_loader.dart';
import 'movie_poster_card.dart';

/// New release movies section widget
class NewReleaseSection extends StatefulWidget {
  const NewReleaseSection({super.key});

  @override
  State<NewReleaseSection> createState() => _NewReleaseSectionState();
}

class _NewReleaseSectionState extends State<NewReleaseSection> {
  final MovieService _movieService = MovieService();
  List<Movie> _newReleaseMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNewReleaseMovies();
  }

  Future<void> _loadNewReleaseMovies() async {
    setState(() {
      _isLoading = true;
    });

    final movies = await _movieService.getNewReleaseMovies();

    if (mounted) {
      setState(() {
        _newReleaseMovies = movies;
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
          child: AppLoader(message: 'Loading new releases...'),
        ),
      );
    }

    if (_newReleaseMovies.isEmpty) {
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
              //   Icons.new_releases,
              //   color: Colors.redAccent,
              //   size: 20,
              // ),
              const SizedBox(width: 8),
              Text(
                'New Releases',
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
            itemCount: _newReleaseMovies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < _newReleaseMovies.length - 1 ? 12 : 0,
                ),
                child: MoviePosterCard(
                  movie: _newReleaseMovies[index],
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
