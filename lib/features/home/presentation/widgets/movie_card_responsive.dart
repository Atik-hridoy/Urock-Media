import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_scale.dart';
import '../../data/movie_model.dart';

/// Responsive card widget for displaying a single movie
/// Automatically scales for mobile, tablet, desktop, and TV
class MovieCardResponsive extends StatelessWidget {
  final Movie movie;

  const MovieCardResponsive({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: movie,
        );
      },
      child: SizedBox(
        width: context.sw(150), // Responsive width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPoster(context),
            SizedBox(height: context.sp(8)), // Responsive spacing
            _buildTitle(context),
            _buildRating(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return Container(
      height: context.sh(200), // Responsive height
      width: context.sw(150),  // Responsive width
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(context.sp(12)), // Responsive radius
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            blurRadius: context.sp(8), // Responsive blur
            offset: Offset(0, context.sp(4)), // Responsive offset
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.sp(12)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // TODO: Replace with actual image when API is connected
            Container(
              color: AppColors.surface,
              child: Icon(
                Icons.movie,
                size: context.si(48), // Responsive icon size
                color: AppColors.grey,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      movie.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: context.sf(14), // Responsive font size
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: context.si(16), // Responsive icon size
          color: AppColors.warning,
        ),
        SizedBox(width: context.sp(4)), // Responsive spacing
        Text(
          movie.formattedRating,
          style: TextStyle(
            fontSize: context.sf(12), // Responsive font size
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        if (movie.releaseYear != null) ...[
          SizedBox(width: context.sp(8)), // Responsive spacing
          Text(
            '• ${movie.releaseYear}',
            style: TextStyle(
              fontSize: context.sf(12), // Responsive font size
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ],
    );
  }
}

/// Example: Responsive Movie Grid
class ResponsiveMovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const ResponsiveMovieGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    // Get responsive column count
    final columns = ResponsiveScale.gridColumns(
      mobile: 2,
      tablet: 3,
      desktop: 4,
      tv: 6,
    );

    return GridView.builder(
      padding: EdgeInsets.all(context.sp(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: ResponsiveScale.aspectRatio(
          mobile: 0.65,
          tablet: 0.65,
          desktop: 0.65,
          tv: 0.7,
        ),
        crossAxisSpacing: context.sp(16),
        mainAxisSpacing: context.sp(16),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCardResponsive(movie: movies[index]);
      },
    );
  }
}

/// Example: Responsive Movie List (Horizontal Scroll)
class ResponsiveMovieList extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const ResponsiveMovieList({
    super.key,
    required this.movies,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sp(16),
            vertical: context.sp(12),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: context.sf(20), // Responsive font
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Horizontal List
        SizedBox(
          height: context.sh(280), // Responsive height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: context.sp(16)),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: context.sp(16)),
                child: MovieCardResponsive(movie: movies[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
