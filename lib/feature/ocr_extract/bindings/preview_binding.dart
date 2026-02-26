import 'package:get/get.dart';
import 'package:test_projectt/feature/ocr_extract/controller/preview_controller.dart';

class PreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewController>(() => PreviewController());
  }
}
