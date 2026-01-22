import 'package:flutter/material.dart';
import '../../../core/utils/responsive_scale.dart';
import 'presentation/series_details_screen_api.dart';
import '../home/data/movie_model.dart';

/// Entry widget that routes to series-specific details screen
class SeriesDetailsEntry extends StatelessWidget {
  final Movie series;

  const SeriesDetailsEntry({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);

    // Use API-integrated series details screen
    return SeriesDetailsScreenApi(series: series);
  }
}
