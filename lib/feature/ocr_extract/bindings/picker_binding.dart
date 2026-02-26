import 'package:get/get.dart';
import 'package:test_projectt/feature/ocr_extract/controller/file_picker_controller.dart';

class PickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilePickerController>(() => FilePickerController());
  }
}
