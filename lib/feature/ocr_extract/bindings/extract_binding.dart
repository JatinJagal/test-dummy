import 'package:get/get.dart';
import 'package:test_projectt/feature/ocr_extract/controller/extract_content_controller.dart';

class ExtractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtractContentController>(() => ExtractContentController());
  }
}
