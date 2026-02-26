import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart';
import 'package:test_projectt/core/utils/common_widgets/custom_button.dart';
import 'package:test_projectt/core/utils/common_widgets/custom_textfield.dart';
import 'package:test_projectt/core/utils/responsive.dart';
import 'package:test_projectt/feature/authentication/login/controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.rw(24)),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      "Welcome Back!",
                      style: Styles.txt24W600.copyWith(
                        color: AppColors.primary,
                        fontSize: context.rsp(24),
                      ),
                    ),
                    SizedBox(height: context.rh(8)),
                    Text(
                      "Sign in to continue to Shopy",
                      style: Styles.txt16W400.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: context.rsp(16),
                      ),
                    ),
                    SizedBox(height: context.rh(48)),

                    // Username Field
                    CustomTextfield(
                      controller: controller.usernameController,
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: controller.validateUsername,
                    ),
                    SizedBox(height: context.rh(16)),

                    // Password Field
                    CustomTextfield(
                      controller: controller.passwordController,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true, // Initial state
                      showPasswordToggle: true, // Handle toggle internally
                      validator: controller.validatePassword,
                    ),
                    SizedBox(height: context.rh(16)),

                    // Forgot Password (Optional placeholder)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        text: "Forgot Password?",
                        type: AppButtonType.text,
                        onPressed: () {},
                        textStyle: Styles.txt14W600.copyWith(
                          color: AppColors.primary,
                          fontSize: context.rsp(14),
                        ),
                        padding:
                            EdgeInsets.zero, // Remove padding for alignment
                      ),
                    ),
                    SizedBox(height: context.rh(24)),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => CustomButton(
                          text: "Login",
                          borderRadius: 12,
                          size: AppButtonSize.large,
                          isLoading: controller.isLoading.value,
                          onPressed: controller.login,
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          textStyle: Styles.txt16W600.copyWith(
                            color: Colors.white,
                            fontSize: context.rsp(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
