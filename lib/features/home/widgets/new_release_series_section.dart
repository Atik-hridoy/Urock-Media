import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/widgets/app_loader.dart';
import 'movie_poster_card.dart';

/// New release series section widget
class NewReleaseSeriesSection extends StatefulWidget {
  const NewReleaseSeriesSection({super.key});

  @override
  State<NewReleaseSeriesSection> createState() => _NewReleaseSeriesSectionState();
}

class _NewReleaseSeriesSectionState extends State<NewReleaseSeriesSection> {
  final MovieService _movieService = MovieService();
  List<Movie> _newReleaseSeries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNewReleaseSeries();
  }

  Future<void> _loadNewReleaseSeries() async {
    setState(() {
      _isLoading = true;
    });

    final series = await _movieService.getNewReleaseSeries();

    if (mounted) {
      setState(() {
        _newReleaseSeries = series;
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
          child: AppLoader(message: 'Loading new series...'),
        ),
      );
    }

    if (_newReleaseSeries.isEmpty) {
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
                'New Release Series',
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
            itemCount: _newReleaseSeries.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < _newReleaseSeries.length - 1 ? 12 : 0,
                ),
                child: MoviePosterCard(
                  movie: _newReleaseSeries[index],
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
