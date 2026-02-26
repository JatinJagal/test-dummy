import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';
import 'package:test_projectt/feature/products/repository/product_repository.dart';

class ProductsController extends GetxController {
  final ProductRepository _repository = ProductRepository();
  final ScrollController scrollController = ScrollController();

  final RxList<Products> products = <Products>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  final RxString errorMessage = ''.obs;

  var skip = 0;
  final int limit = 10;
  var hasMore = true;

  @override
  void onInit() {
    super.onInit();
    getProductsInitial();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (hasMore && !isMoreLoading.value && !isLoading.value) {
        getMoreProducts();
      }
    }
  }

  Future<void> getProductsInitial() async {
    isLoading.value = true;
    errorMessage.value = '';
    skip = 0;
    hasMore = true;

    final result = await _repository.getProductsList(limit: limit, skip: skip);

    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (data) {
        if (data.products != null) {
          products.assignAll(data.products!);
          if (data.products!.length < limit) {
            hasMore = false;
          }
          skip += limit;
        } else {
          hasMore = false;
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> getMoreProducts() async {
    isMoreLoading.value = true;

    final result = await _repository.getProductsList(limit: limit, skip: skip);

    result.fold(
      (error) {
        Get.snackbar("Error", error);
      },
      (data) {
        if (data.products != null && data.products!.isNotEmpty) {
          products.addAll(data.products!);
          skip += limit;
          if (data.products!.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }
      },
    );

    isMoreLoading.value = false;
  }
}
