import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:test_projectt/core/routes/app_page.dart';
import 'package:test_projectt/feature/ocr_extract/controller/preview_controller.dart';

class PreviewScreen extends GetView<PreviewController> {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text('File Preview'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Obx(() {
                  final file = controller.file;
                  if (file == null) {
                    return const Text('No file to preview');
                  }

                  final fileName = p.basename(file.path);
                  final isImage = controller.isImage(file.path);

                  return isImage
                      ? Image.file(file, fit: BoxFit.contain)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.insert_drive_file,
                              size: 100,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              fileName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                }),
              ),
            ),
            const SizedBox(height: 40),
            Obx(() {
              if (controller.file == null) return const SizedBox.shrink();
              return SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      Routes.EXTRACT_TEXT,
                      arguments: controller.file,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Extract Text',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
