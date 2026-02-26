import 'dart:io';

import 'package:doc_text_extractor/doc_text_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path/path.dart' as p;

class ExtractContentController extends GetxController {
  final _file = Rxn<File>();
  File? get file => _file.value;

  // Controllers for receipt fields
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();
  final notesController = TextEditingController();
  final fullTextController = TextEditingController();

  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is File) {
      _file.value = Get.arguments as File;
      extractText();
    } else {
      errorMessage.value = 'No file provided for extraction.';
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    categoryController.dispose();
    notesController.dispose();
    fullTextController.dispose();
    super.onClose();
  }

  Future<void> extractText() async {
    if (file == null) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final extension = p.extension(file!.path).toLowerCase();
      String extractedText = '';

      if (['.jpg', '.jpeg', '.png'].contains(extension)) {
        extractedText = await _extractFromImage();
      } else if (extension == '.pdf') {
        extractedText = await _extractFromPdf();
      } else if (['.doc', '.docx'].contains(extension)) {
        extractedText = await _extractFromDoc();
      } else {
        throw Exception('Unsupported file format: $extension');
      }

      fullTextController.text = extractedText;
      _parseExtractedText(extractedText);
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Error extracting text: $e';
      isLoading.value = false;
    }
  }

  void _parseExtractedText(String text) {
    // 1. Try to find Amount
    // Matches patterns like $12.34, 12.34, 1,234.56
    final amountRegex = RegExp(r'(\d{1,3}(?:,\d{3})*(?:\.\d{2})?)');
    final amountMatches = amountRegex.allMatches(text);
    if (amountMatches.isNotEmpty) {
      // Often the largest number or the one near "Total" is the amount.
      // For now, we'll take the first reasonable looking decimal match.
      for (final match in amountMatches) {
        final val = match.group(0);
        if (val != null && val.contains('.')) {
          amountController.text = val;
          break;
        }
      }
    }

    // 2. Try to find Date
    // Matches DD/MM/YYYY, MM/DD/YYYY, YYYY-MM-DD etc.
    final dateRegex = RegExp(r'(\d{1,4}[-/.]\d{1,2}[-/.]\d{1,4})');
    final dateMatch = dateRegex.firstMatch(text);
    if (dateMatch != null) {
      dateController.text = dateMatch.group(0) ?? '';
    }

    // 3. Try to find Title (maybe the first line or a capitalized string)
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isNotEmpty) {
      titleController.text = lines.first.trim();
    }

    // 4. Category (keywords)
    final categoryKeywords = {
      'Food': [
        'restaurant',
        'cafe',
        'mcdonald',
        'burger',
        'pizza',
        'food',
        'dining',
      ],
      'Travel': [
        'uber',
        'taxi',
        'flight',
        'hotel',
        'airbnb',
        'travel',
        'gas',
        'fuel',
      ],
      'Shopping': ['walmart', 'amazon', 'target', 'store', 'shop', 'mall'],
      'Utilities': ['electric', 'water', 'internet', 'bill', 'phone'],
    };

    String detectedCategory = 'General';
    for (final entry in categoryKeywords.entries) {
      for (final keyword in entry.value) {
        if (text.toLowerCase().contains(keyword)) {
          detectedCategory = entry.key;
          break;
        }
      }
      if (detectedCategory != 'General') break;
    }
    categoryController.text = detectedCategory;
  }

  Future<String> _extractFromImage() async {
    final inputImage = InputImage.fromFile(file!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }

  Future<String> _extractFromPdf() async {
    PDFDoc doc = await PDFDoc.fromFile(file!);
    String text = await doc.text;
    return text;
  }

  Future<String> _extractFromDoc() async {
    try {
      final extractor = TextExtractor();
      final result = await extractor.extractText(file!.path, isUrl: false);
      return result.text;
    } catch (e) {
      return 'Error extracting from Doc: $e';
    }
  }
}
