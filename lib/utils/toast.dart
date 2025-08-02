import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toast {
  static void showToast({bool iserror = false, String? error, required String message}) {
    Get.snackbar(
      iserror ? error ?? 'Error' : 'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: iserror ? Colors.red : Color(0XFF4bb543),
    );
  }
}
