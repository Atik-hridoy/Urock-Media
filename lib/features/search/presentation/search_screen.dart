import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/recommended_movies_grid.dart';

/// Search screen for movies and series
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SearchBarWidget(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _isSearching = value.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () {
                      // TODO: Show filter options
                    },
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : const RecommendedMoviesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return const Center(
      child: Text(
        'Search results will appear here',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
