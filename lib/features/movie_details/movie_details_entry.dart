import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import '../home/data/movie_model.dart';
import 'presentation/details_screen.dart' as legacy_details;
import 'presentation/tv_details_screen.dart' as tv_details;

/// Chooses between phone/tablet and TV details layouts.
class MovieDetailsEntry extends StatelessWidget {
  final Movie movie;

  const MovieDetailsEntry({super.key, required this.movie});

  bool _isTvLayout(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppSizes.desktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    if (_isTvLayout(context)) {
      return tv_details.TvDetailsScreen(movie: movie);
    }
    return legacy_details.DetailsScreen(movie: movie);
  }
}
