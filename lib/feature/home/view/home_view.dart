import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart';
import 'package:test_projectt/core/routes/app_page.dart';
import 'package:test_projectt/core/utils/responsive.dart';
import 'package:test_projectt/feature/home/controller/home_controller.dart';
import 'package:test_projectt/feature/home/view/widgets/product_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Home", style: txt18W600),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PICK_FILE);
            },
            icon: const Icon(Icons.file_upload_outlined, color: Colors.black),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(height: context.rh(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.rw(20.0)),
              child: Row(
                children: [
                  Text(
                    "New Arrivals",
                    style: txt18W600.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: context.rsp(18),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.PRODUCTS);
                    },
                    child: Text(
                      "See All",
                      style: txt14W600.copyWith(
                        color: AppColors.primary,
                        fontSize: context.rsp(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.rh(16)),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (controller.products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: context.rw(20)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context)
                      ? 4
                      : (Responsive.isTablet(context) ? 3 : 2),
                  crossAxisSpacing: context.rw(16),
                  mainAxisSpacing: context.rh(16),
                  childAspectRatio: Responsive.isTablet(context) ? 0.75 : 0.7,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: controller.products[index]);
                },
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
