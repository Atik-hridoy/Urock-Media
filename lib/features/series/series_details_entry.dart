import 'package:flutter/material.dart';
import '../../../core/utils/responsive_scale.dart';
import 'presentation/series_details_screen.dart';
import '../home/data/movie_model.dart';

/// Entry widget that routes to series-specific details screen
class SeriesDetailsEntry extends StatelessWidget {
  final Movie series;

  const SeriesDetailsEntry({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);

    // For now, use the same series details screen for all device types
    // Can be extended to have phone/tablet specific layouts if needed
    return SeriesDetailsScreen(series: series);
  }
}
