import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart';
import 'package:test_projectt/feature/cart/controller/cart_controller.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';

class ProductTileCard extends StatelessWidget {
  final Products product;

  const ProductTileCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Container(
              width: 120,
              height: 120,
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
          ),

          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "No Title",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: txt16W600,
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
                        style: txt18W600.copyWith(color: AppColors.primary),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.isRegistered<CartController>()) {
                            Get.find<CartController>().addToCart(product);
                          } else {
                            Get.put(CartController()).addToCart(product);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
