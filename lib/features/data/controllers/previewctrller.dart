import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:todo_app/core/permissions.dart';
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

  Future<void> saveToDownloads() async {
    await MediaStore.ensureInitialized();
    MediaStore.appFolder = "MyTodoApp";

    final granted = await requestSmartPermission();
    if (!granted) {
      Toast.showToast(message: 'Permission denied', iserror: true);
      return;
    }

    final mediaStore = MediaStore();

    final result = await mediaStore.saveFile(
      tempFilePath: file.path,
      dirType: DirType.download,
      dirName: DirName.download,
    );

    if (result != null && result.isSuccessful) {
      print("File saved: ${result.uri}");
      Toast.showToast(message: 'Download successful');
    } else {
      print("Download failed: ${result?.name}");
      Toast.showToast(message: 'Download failed', iserror: true);
    }
  }
}
