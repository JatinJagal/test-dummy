import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:test_projectt/feature/ocr_extract/controller/extract_content_controller.dart';

class ExtractContentScreen extends GetView<ExtractContentController> {
  const ExtractContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text('Receipt Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.extractText(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Processing receipt, please wait...'),
              ],
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.extractText,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final file = controller.file;
        final isImage =
            file != null &&
            [
              '.jpg',
              '.jpeg',
              '.png',
            ].contains(p.extension(file.path).toLowerCase());

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isImage) ...[
                const Text(
                  'Receipt Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Image.file(file, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              _buildField('Title', controller.titleController, Icons.title),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      'Amount',
                      controller.amountController,
                      Icons.attach_money,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildField(
                      'Date',
                      controller.dateController,
                      Icons.calendar_today,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              _buildField(
                'Category',
                controller.categoryController,
                Icons.category,
              ),
              const SizedBox(height: 15),

              _buildField(
                'Notes',
                controller.notesController,
                Icons.note,
                maxLines: 3,
              ),
              const SizedBox(height: 25),

              const Divider(),
              const SizedBox(height: 10),

              const Text(
                'Full Extracted Text',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.fullTextController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Full text will appear here...',
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to save or proceed
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Receipt details saved locally (simulation)',
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
                    'Save Details',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
      ),
    );
  }
}
