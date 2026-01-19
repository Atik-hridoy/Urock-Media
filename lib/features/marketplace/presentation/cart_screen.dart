import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/cart_item_card.dart';

/// Shopping cart screen
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _controller = Get.isRegistered<MarketplaceController>()
      ? Get.find<MarketplaceController>()
      : Get.put(MarketplaceController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchCart();
  }

  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Hiking Traveler Backpack',
      'size': 'M',
      'color': 'Yellow',
      'price': 149.99,
      'quantity': 1,
    },
    {
      'name': 'Hiking Traveler Backpack',
      'size': 'M',
      'color': 'Yellow',
      'price': 149.99,
      'quantity': 1,
    },
    {
      'name': 'Hiking Traveler Backpack',
      'size': 'M',
      'color': 'Yellow',
      'price': 149.99,
      'quantity': 1,
    },
  ];

  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        final cart = _controller.cartItem.value;

        if (cart == null || cart.products.isEmpty) {
          return const Center(child: Text("No item found"));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cart.products.length,
                itemBuilder: (context, index) {
                  final item = cart.products[index];
                  return CartItemCard(
                    name: item.productName,
                    size: item.selectedAttributes['Size'] ?? "N/A",
                    color: item.selectedAttributes['Color'],
                    price: item.price,
                    quantity: item.quantity,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        cartItems[index]['quantity'] = newQuantity;
                      });
                    },
                    onRemove: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            // Checkout Button
            Container(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/checkout');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldLight,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Checkout : \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
