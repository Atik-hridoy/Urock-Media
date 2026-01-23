import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/checkout_controller.dart';
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
  final _controller = MarketplaceController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchCart();
  }

  // final List<Map<String, dynamic>> cartItems = [
  //   {
  //     'name': 'Hiking Traveler Backpack',
  //     'size': 'M',
  //     'color': 'Yellow',
  //     'price': 149.99,
  //     'quantity': 1,
  //   },
  //   {
  //     'name': 'Hiking Traveler Backpack',
  //     'size': 'M',
  //     'color': 'Yellow',
  //     'price': 149.99,
  //     'quantity': 1,
  //   },
  //   {
  //     'name': 'Hiking Traveler Backpack',
  //     'size': 'M',
  //     'color': 'Yellow',
  //     'price': 149.99,
  //     'quantity': 1,
  //   },
  // ];

  // double get totalPrice {
  //   return cartItems.fold(
  //     0,
  //     (sum, item) => sum + (item['price'] * item['quantity']),
  //   );
  // }

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
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final cart = _controller.cartItem.value;
          if (_controller.isLoading.first) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
              ),
            );
          }
          if (cart == null || cart.products.isEmpty) {
            return NoData(onPressed: () => _controller.onRefreshCart());
          }
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator.adaptive(
                  color: AppColors.white,
                  onRefresh: () => _controller.onRefreshCart(),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final item = cart.products[index];
                      return CartItemCard(
                        image: ApiConfig.imageUrl + item.productImage,
                        name: item.productName,
                        size: item.selectedAttributes['Size'] ?? "",
                        color: item.selectedAttributes['Color'] ?? "",
                        price: item.price,
                        quantity: item.quantity,
                        isSimpleProduct: item.productType == 'simple',
                        onQuantityIncrease: () {
                          setState(() {
                            item.quantity += 1;
                          });
                          _controller.onquantityIncrease(
                            item.product.id,
                            item.variantId,
                          );
                        },
                        onQuantityDecrease: () {
                          setState(() {
                            item.quantity -= 1;
                          });
                          _controller.onQuantityDecrease(
                            item.product.id,
                            item.variantId,
                          );
                        },
                        onRemove: () async {
                          setState(() {
                            cart.products.removeAt(index);
                          });
                          final message = await _controller.onDeleteCart(
                            item.id,
                            variantId: item.variantId,
                          );
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(SnackBar(content: Text(message)));
                        },
                      );
                    },
                  ),
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
                        CheckoutController().onPlaceOrder(context);
                        // Navigator.of(context).pushNamed('/checkout');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldLight,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Checkout : \$${cart.totalAmount.toStringAsFixed(2)}',
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
        },
      ),
    );
  }
}
