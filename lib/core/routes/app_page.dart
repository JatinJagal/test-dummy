import 'package:get/get.dart';
import 'package:test_projectt/feature/authentication/login/binding/login_binding.dart';
import 'package:test_projectt/feature/authentication/login/view/login_view.dart';
import 'package:test_projectt/feature/dashboard/binding/dashboard_binding.dart';
import 'package:test_projectt/feature/dashboard/view/dashboard_view.dart';
import 'package:test_projectt/feature/ocr_extract/bindings/extract_binding.dart';
import 'package:test_projectt/feature/ocr_extract/bindings/picker_binding.dart';
import 'package:test_projectt/feature/ocr_extract/bindings/preview_binding.dart';
import 'package:test_projectt/feature/ocr_extract/view/extract_content_screen.dart';
import 'package:test_projectt/feature/ocr_extract/view/file_picker_screen.dart';
import 'package:test_projectt/feature/ocr_extract/view/preview_screen.dart';
import 'package:test_projectt/feature/products/binding/products_binding.dart';
import 'package:test_projectt/feature/products/view/products_view.dart';
import 'package:test_projectt/feature/splash/binding/splash_binding.dart';
import 'package:test_projectt/feature/splash/view/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PICK_FILE,
      page: () => const FilePickerScreen(),
      binding: PickerBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW_FILE,
      page: () => const PreviewScreen(),
      binding: PreviewBinding(),
    ),
    GetPage(
      name: _Paths.EXTRACT_TEXT,
      page: () => const ExtractContentScreen(),
      binding: ExtractBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
  ];
}
