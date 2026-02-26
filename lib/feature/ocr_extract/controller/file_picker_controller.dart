import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class FilePickerController extends GetxController {
  final _selectedFile = Rxn<File>();
  File? get selectedFile => _selectedFile.value;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      _selectedFile.value = File(result.files.single.path!);
    }
  }

  void clearFile() {
    _selectedFile.value = null;
  }
}
