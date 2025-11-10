import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../logic/home_controller.dart';
import '../widgets/featured_content.dart';
import '../widgets/movie_section.dart';
import '../widgets/bottom_nav_bar.dart';

/// Home screen with tabs and content sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();
  late TabController _tabController;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _controller.loadMovies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Inbox
        Navigator.of(context).pushNamed('/inbox');
        break;
      case 2:
        // Marketplace
        Navigator.of(context).pushNamed('/marketplace');
        break;
      case 3:
        // Live TV
        Navigator.of(context).pushNamed('/live-tv');
        break;
      case 4:
        // Profile
        Navigator.of(context).pushNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildHomeTab(),
              _buildMoviesTab(),
              _buildSeriesTab(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
          _handleBottomNavTap(index);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AppColors.goldLight,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha:0.6),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: 'Home'),
          Tab(text: 'Movies'),
          Tab(text: 'Series'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            // TODO: Show notifications
          },
        ),
      ],
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          FeaturedContent(
            movie: _controller.featuredMovies.isNotEmpty 
                ? _controller.featuredMovies.first 
                : null,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Popular Movies',
            movies: _controller.popularMovies,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Popular Series',
            movies: _controller.trendingMovies,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'My Watchlist',
            movies: _controller.topRatedMovies,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMoviesTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          FeaturedContent(
            movie: _controller.featuredMovies.isNotEmpty 
                ? _controller.featuredMovies.first 
                : null,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Trending Movies',
            movies: _controller.trendingMovies,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Top Rated',
            movies: _controller.topRatedMovies,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSeriesTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          FeaturedContent(
            movie: _controller.featuredMovies.isNotEmpty 
                ? _controller.featuredMovies.first 
                : null,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Trending Series',
            movies: _controller.trendingMovies,
            isSeries: true,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Popular Series',
            movies: _controller.popularMovies,
            isSeries: true,
          ),
          const SizedBox(height: 24),
          MovieSection(
            title: 'Top Rated Series',
            movies: _controller.topRatedMovies,
            isSeries: true,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
