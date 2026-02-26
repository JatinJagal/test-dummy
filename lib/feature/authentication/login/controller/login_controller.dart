import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/preferences/user_preferences.dart';
import 'package:test_projectt/core/routes/app_page.dart';
import 'package:test_projectt/core/utils/validators.dart';
import 'package:test_projectt/feature/authentication/repository/authentication_repository.dart';

class LoginController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Validators are now in Validators class
  // String? validateUsername(String? value) => Validators.validateUsername(value);
  // String? validatePassword(String? value) => Validators.validatePassword(value);
  // Actually, better to just use them directly in the View or wrap them here if needed for some reason.
  // The user asked to "use in this file", so I will wrap them.

  String? validateUsername(String? value) => Validators.validateUsername(value);

  String? validatePassword(String? value) => Validators.validatePassword(value);

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    final result = await _repository.login(
      usernameController.text.trim(),
      passwordController.text,
    );

    isLoading.value = false;

    result.fold(
      (error) {
        Get.snackbar(
          "Failed",
          error,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (response) async {
        // Save token
        if (response.accessToken != null) {
          // print("This is token${response.accessToken}");
          AppSession.setAccessToken(response.accessToken);
          Get.offAllNamed(Routes.DASHBOARD);
        }

        // Navigate to Dashboard
      },
    );
  }
}
