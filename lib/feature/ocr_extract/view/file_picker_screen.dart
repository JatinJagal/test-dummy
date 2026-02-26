import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/routes/app_page.dart';
import 'package:test_projectt/feature/ocr_extract/controller/file_picker_controller.dart';

class FilePickerScreen extends GetView<FilePickerController> {
  const FilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text('Pick a File'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: controller.pickFile,
              icon: const Icon(Icons.file_upload),
              label: const Text('Pick Image, PDF or Doc'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              final selectedFile = controller.selectedFile;
              if (selectedFile != null) {
                return Column(
                  children: [
                    Text(
                      'Selected File: ${selectedFile.path.split('/').last}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.PREVIEW_FILE,
                          arguments: selectedFile,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                );
              } else {
                return const Text('No file selected');
              }
            }),
          ],
        ),
      ),
    );
  }
}
