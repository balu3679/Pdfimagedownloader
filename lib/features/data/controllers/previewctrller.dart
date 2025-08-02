import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/utils/toast.dart';

class PreviewController extends GetxController {
  late File file;
  final RxDouble downloadProgress = 0.0.obs;
  late PDFViewController pdfViewController;

  var isReady = false.obs;
  var totalPages = 0.obs;
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    file = Get.arguments as File;
  }

  void setPdfViewController(PDFViewController controller) {
    pdfViewController = controller;
  }

  void updateTotalPages(int? pages) {
    totalPages.value = pages ?? 0;
    isReady.value = true;
  }

  void updateCurrentPage(int? page) {
    currentPage.value = page ?? 0;
  }

  Future<void> downloadFile() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      Get.snackbar("Permission Denied", "Storage permission is required");
      return;
    }

    try {
      final fileName = p.basename(file.path);
      final downloadsDir = await getDownloadsDirectory() ?? await getExternalStorageDirectory();

      if (downloadsDir == null) {
        Toast.showToast(message: 'Unable to access storage', iserror: true);
        return;
      }

      final targetPath = "${downloadsDir.path}/$fileName";
      final targetFile = File(targetPath);
      final totalBytes = await file.length();

      Get.dialog(_buildProgressDialog(), barrierDismissible: false);

      final sourceStream = file.openRead();
      final sink = targetFile.openWrite();
      int downloadedBytes = 0;

      await for (final chunk in sourceStream) {
        downloadedBytes += chunk.length;
        sink.add(chunk);
        downloadProgress.value = downloadedBytes / totalBytes;
      }

      await sink.close();
      Get.back();
      Toast.showToast(message: 'Saved to $targetPath');
    } catch (e) {
      Get.back();
      Toast.showToast(message: 'Download failed: $e', iserror: true);
    }
  }

  Widget _buildProgressDialog() {
    return AlertDialog(
      title: const Text("Downloading..."),
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: downloadProgress.value),
            const SizedBox(height: 10),
            Text("${(downloadProgress.value * 100).toStringAsFixed(0)}%"),
          ],
        ),
      ),
    );
  }
}
