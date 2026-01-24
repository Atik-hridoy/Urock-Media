import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Cart item card widget
class CartItemCard extends StatelessWidget {
  final String name;
  final String size;
  final String color;
  final double price;
  final int quantity;
  final String image;
  final bool isSimpleProduct;
  final Function() onQuantityIncrease;
  final Function() onQuantityDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.onRemove,
    required this.onQuantityIncrease,
    required this.onQuantityDecrease,
    required this.image,
    required this.isSimpleProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          SizedBox(
            width: 70,
            height: 70,

            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(8),
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [Colors.grey[700]!, Colors.grey[900]!],
            //   ),
            // ),
            child: Center(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.backpack,
                  size: 30,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!isSimpleProduct) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Size: $size    Color: $color',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Controls and Remove
          Column(
            children: [
              // Remove Button
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 8),
              // Quantity Controls
              Row(
                children: [
                  // Decrease Button
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        onQuantityDecrease();
                      }
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Quantity
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Increase Button
                  GestureDetector(
                    onTap: () {
                      onQuantityIncrease();
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.goldLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
