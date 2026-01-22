import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Product card widget for marketplace
class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final String id;
  final bool isBookedmark;
  final VoidCallback onAddBookmark;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.id,
    required this.onAddBookmark,
    required this.isBookedmark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product-details', arguments: id);
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => ProductDetailsScreen(id: id)),
        // );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [Colors.grey[700]!, Colors.grey[900]!],
                    // ),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.checkroom,
                          size: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                // Favorite Icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onAddBookmark,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookedmark ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      color: AppColors.goldLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
