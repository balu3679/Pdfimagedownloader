import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/data/controllers/previewctrller.dart';

class FilePreviewScreen extends StatelessWidget {
  const FilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviewController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        actions: [
          Obx(
            () =>
                controller.isReady.value
                    ? Center(
                      child: Text(
                        "${controller.currentPage.value + 1}/${controller.totalPages.value}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                    : const SizedBox(),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: controller.downloadFile,
          ),
        ],
      ),
      body: _buildBody(controller),
    );
  }

  Widget _buildBody(PreviewController controller) {
    final path = controller.file.path;
    if (path.endsWith('.pdf')) {
      return PDFView(
        filePath: path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        onRender: (pages) => controller.updateTotalPages(pages),
        onViewCreated: (vc) => controller.setPdfViewController(vc),
        onPageChanged: (page, total) => controller.updateCurrentPage(page),
        onError: (error) => print("PDFView error: $error"),
      );
    } else if (path.endsWith('.jpg') || path.endsWith('.png')) {
      return Center(child: Image.file(controller.file));
    }
    return const Center(child: Text('Unsupported file type'));
  }
}
