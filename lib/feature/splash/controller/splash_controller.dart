import 'package:get/get.dart';
import 'package:test_projectt/core/preferences/user_preferences.dart';
import 'package:test_projectt/core/routes/app_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    print("This is token${AppSession.getAccessToken()}");
    await Future.delayed(const Duration(seconds: 3));
    if (AppSession.getAccessToken().isNotEmpty) {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
