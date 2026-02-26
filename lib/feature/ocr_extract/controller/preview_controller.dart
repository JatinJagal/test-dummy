import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class PreviewController extends GetxController {
  final _file = Rxn<File>();
  File? get file => _file.value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is File) {
      _file.value = Get.arguments as File;
    }
  }

  bool isImage(String path) {
    final extension = p.extension(path).toLowerCase();
    return ['.jpg', '.jpeg', '.png'].contains(extension);
  }
}
