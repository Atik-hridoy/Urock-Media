import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import 'related_movie_card.dart';

/// Related movies section with vertical scrolling
class RelatedMoviesSection extends StatelessWidget {
  const RelatedMoviesSection({super.key});

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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: aspectRatio,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return const RelatedMovieCard();
            },
          ),
        ],
      ),
    );
  }
}
