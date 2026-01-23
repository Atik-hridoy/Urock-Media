import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/category_icon.dart';
import '../widgets/product_card.dart';

/// Marketplace screen
class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedNavIndex = 2; // Marketplace is at index 2
  final _scrollController = List.generate(
    4,
    (index) => ScrollController(),
  ); // [0 -> category, 1 -> feature product, 2 -> popular product, 3 -> trending product]

  // final List<Map<String, dynamic>> categories = [
  //   {'name': 'Clothing', 'icon': Icons.checkroom},
  //   {'name': 'Electronics', 'icon': Icons.devices},
  //   {'name': 'Home Appliances', 'icon': Icons.kitchen},
  //   {'name': 'Clothing', 'icon': Icons.chair},
  // ];
  final _controller = MarketplaceController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchCategory();
    _controller.loadProducts();
    _controller.loadPopularProducts();
    _controller.loadTrendingProducts();
    _scrollController[1].addListener(() {
      if (_scrollController[1].position.pixels >=
          _scrollController[1].position.maxScrollExtent - 200) {
        _controller.loadProducts();
      }
    });
    _scrollController[2].addListener(() {
      if (_scrollController[2].position.pixels >=
          _scrollController[2].position.maxScrollExtent - 200) {
        _controller.loadPopularProducts();
      }
    });
    _scrollController[3].addListener(() {
      if (_scrollController[3].position.pixels >=
          _scrollController[3].position.maxScrollExtent - 200) {
        _controller.loadTrendingProducts();
      }
    });
    _scrollController[0].addListener(() {
      if (_scrollController[0].position.pixels >=
          _scrollController[0].position.maxScrollExtent - 200) {
        _controller.fetchCategory();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController[2].dispose();
    _scrollController[3].dispose();
    _scrollController[1].dispose();
    _scrollController[0].dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => RefreshIndicator.adaptive(
          color: AppColors.white,
          onRefresh: () => _controller.onRefresh(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            onSubmitted: (value) =>
                                _controller.searchProducts(value),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories
                if (_controller.categories.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: _controller.isLoading.first
                        ? Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.white,
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController[0],
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _controller.categories.length,
                            itemBuilder: (context, index) {
                              final item = _controller.categories[index];
                              return CategoryIcon(
                                name: item.name,
                                id: item.id,
                                icon: "${ApiConfig.imageUrl}${item.image}",
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 24),
                ],
                // Feature Products
                _buildProductSection(
                  'Feature Products',
                  _controller.products,
                  _controller.isLoading[1],
                  _scrollController[1],
                ),

                // Popular Products
                _buildProductSection(
                  'Popular Products',
                  _controller.popularProduct,
                  _controller.isLoading[2],
                  _scrollController[2],
                ),

                // Trending Products
                _buildProductSection(
                  'Trending Products',
                  _controller.trendingProduct,
                  _controller.isLoading[3],
                  _scrollController[3],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
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

  Widget _buildProductSection(
    String title,
    List<ProductModel> products,
    bool isLoading,
    ScrollController scrollController,
  ) {
    if (products.isEmpty && !isLoading) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.white,
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index < 3 ? 12 : 0),
                      child: ProductCard(
                        id: item.id,
                        name: item.name,
                        price: item.productType == "simple"
                            ? item.price
                            : item.variants.firstOrNull?.price ?? 0.0,
                        image: item.images.isEmpty
                            ? ""
                            : ApiConfig.imageUrl + item.images.first,
                        isBookedmark: item.isBookmarked,
                        onAddBookmark: () async {
                          setState(() {
                            item.isBookmarked = !item.isBookmarked;
                          });
                          final message = await _controller.addBookmark(
                            item.id,
                          );
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(SnackBar(content: Text(message)));
                        },
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Inbox
        Navigator.of(context).pushReplacementNamed('/inbox');
        break;
      case 2:
        // Marketplace - already here
        break;
      case 3:
        // Live TV
        Navigator.of(context).pushReplacementNamed('/live-tv');
        break;
      case 4:
        // Profile
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }
}
