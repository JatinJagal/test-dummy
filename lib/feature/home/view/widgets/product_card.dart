import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart';
import 'package:test_projectt/feature/cart/controller/cart_controller.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: CachedNetworkImage(
                      imageUrl:
                          product.thumbnail ??
                          (product.images?.isNotEmpty == true
                              ? product.images!.first
                              : ""),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                  if (product.discountPercentage != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${product.discountPercentage!.toStringAsFixed(0)}% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "No Title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: txt14W600,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description ?? "No Description",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.txt12W400.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                      style: txt16W600.copyWith(color: AppColors.primary),
                    ),
                    Builder(
                      builder: (context) {
                        final controller = Get.isRegistered<CartController>()
                            ? Get.find<CartController>()
                            : Get.put(CartController());

                        return Obx(() {
                          final isInCart = controller.isProductInCart(product);
                          return GestureDetector(
                            onTap: () {
                              if (isInCart) {
                                controller.deleteFromCart(product);
                              } else {
                                controller.addToCart(product);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isInCart
                                    ? AppColors.danger
                                    : AppColors.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                isInCart
                                    ? Icons.remove_shopping_cart
                                    : Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
