import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/device_helper.dart';
import '../../data/movie_model.dart';
import 'movie_card.dart';

/// Grid widget for displaying movies
class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final bool showScrollHint;

  const MovieGrid({
    super.key,
    required this.movies,
    this.showScrollHint = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.movieCardHeight + AppSizes.spacingLG,
      child: Stack(
        children: [
          ListView.builder(
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
          if (showScrollHint)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
        ],
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
