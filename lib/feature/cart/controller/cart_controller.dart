import 'package:get/get.dart';
import 'package:test_projectt/core/services/offline_service.dart';
import 'package:test_projectt/feature/cart/models/cart_item_model.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';

class CartController extends GetxController {
  final OfflineService _offlineService = OfflineService();
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalPrice = 0.0.obs;
  final String _cartKey = 'user_cart';

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    if (_offlineService.hasData(_cartKey)) {
      List<dynamic> data = _offlineService.getData(_cartKey);
      cartItems.value = data.map((e) => CartItem.fromJson(e)).toList();
      calculateTotal();
    }
  }

  void saveCart() {
    _offlineService.saveData(
      _cartKey,
      cartItems.map((e) => e.toJson()).toList(),
    );
    calculateTotal();
  }

  void addToCart(Products product) {
    var index = cartItems.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
    Get.snackbar(
      "Success",
      "Added to cart",
      duration: const Duration(milliseconds: 1000),
    );
    saveCart();
  }

  void removeFromCart(Products product) {
    var index = cartItems.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        cartItems.removeAt(index);
      }
      saveCart();
    }
  }

  void deleteFromCart(Products product) {
    cartItems.removeWhere((element) => element.product.id == product.id);
    saveCart();
  }

  void calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      if (item.product.price != null) {
        total += item.product.price! * item.quantity;
      }
    }
    totalPrice.value = total;
  }

  bool isProductInCart(Products product) {
    return cartItems.any((element) => element.product.id == product.id);
  }
}
