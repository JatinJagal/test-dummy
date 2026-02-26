import 'package:get/get.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';
import 'package:test_projectt/feature/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = HomeRepository();

  final RxList<String> bannerImages = [
    "assets/images/carousel-1.jpg",
    "assets/images/carousel-2.jpg",
    "assets/images/carousel-3.jpg",
    "assets/images/carousel-4.jpg",
  ].obs;

  final RxList<Products> products = <Products>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repository.getProducts();

    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (data) {
        if (data.products != null) {
          products.value = data.products!;
        }
      },
    );

    isLoading.value = false;
  }
}
