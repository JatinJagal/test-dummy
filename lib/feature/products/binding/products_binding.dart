import 'package:get/get.dart';
import 'package:test_projectt/feature/products/controller/products_controller.dart';

/// Placeholder binding for products feature.
class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController());
    // TODO: register controllers or services for the products screen
  }
}
