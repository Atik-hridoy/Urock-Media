// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_sizes.dart';
// import '../../data/movie_model.dart';

// /// Featured section with hero banner
// class FeaturedSection extends StatefulWidget {
//   final List<Movie> movies;

//   const FeaturedSection({
//     super.key,
//     required this.movies,
//   });

//   @override
//   State<FeaturedSection> createState() => _FeaturedSectionState();
// }

// class _FeaturedSectionState extends State<FeaturedSection> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.movies.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return SizedBox(
//       height: 400,
//       child: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemCount: widget.movies.length.clamp(0, 5),
//             itemBuilder: (context, index) {
//               return _buildFeaturedCard(widget.movies[index]);
//             },
//           ),
//           Positioned(
//             bottom: AppSizes.paddingMD,
//             left: 0,
//             right: 0,
//             child: _buildPageIndicator(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeaturedCard(Movie movie) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).pushNamed('/details', arguments: movie);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(AppSizes.radiusLG),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(AppSizes.radiusLG),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Container(
//                 color: AppColors.surface,
//                 child: const Icon(Icons.movie_filter, size: 100, color: AppColors.grey),
//               ),
//               Positioned(
//                 bottom: AppSizes.paddingLG,
//                 left: AppSizes.paddingLG,
//                 right: AppSizes.paddingLG,
//                 child: Text(
//                   movie.title,
//                   style: Theme.of(context).textTheme.displayMedium,
//                   maxLines: 2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         widget.movies.length.clamp(0, 5),
//         (index) => Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           width: _currentPage == index ? 24 : 8,
//           height: 8,
//           decoration: BoxDecoration(
//             color: _currentPage == index ? AppColors.primary : AppColors.grey,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       ),
//     );
//   }
// }
