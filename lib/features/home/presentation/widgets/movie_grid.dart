import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/device_helper.dart';
import '../../data/movie_model.dart';
import 'movie_card.dart';

/// Grid widget for displaying movies
class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.movieCardHeight + AppSizes.spacingLG,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.spacingMD),
            child: MovieCard(movie: movies[index]),
          );
        },
      ),
    );
  }
}

/// Grid view for full movie list
class MovieGridView extends StatelessWidget {
  final List<Movie> movies;

  const MovieGridView({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final columns = DeviceHelper.getGridColumns(context);

    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: AppSizes.movieCardWidth / AppSizes.movieCardHeight,
        crossAxisSpacing: AppSizes.spacingMD,
        mainAxisSpacing: AppSizes.spacingMD,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
