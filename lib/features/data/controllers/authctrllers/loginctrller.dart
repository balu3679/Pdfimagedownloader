import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/domain/repositories/auth.dart';
import 'package:todo_app/utils/toast.dart';

class Loginctrller extends GetxController {
  final _authService = Get.find<Auth>();
  final formkey = GlobalKey<FormState>();
  final emailid = TextEditingController();
  final password = TextEditingController();
  final showpass = Rx<bool>(true);
  final isLoading = false.obs;

  void toggle() {
    showpass.value = !showpass.value;
  }

  Future<void> onsubmit() async {
    if (!formkey.currentState!.validate()) return;
    try {
      isLoading.value = true;
      final result = await _authService.signInWithEmailPassword(emailid.text, password.text);

      if (result.isSuccess) {
        Toast.showToast(message: 'Logged in successfully');
        Get.offAllNamed(Routes.home);
      } else {
        Toast.showToast(
          error: "Login Failed",
          iserror: true,
          message: "Invalid credentials or user not found",
        );
      }
    } catch (e) {
      log('Errrrr : $e');
      log('Errrrr : ${e.toString().replaceFirst('Exception: ', '')}');
      Toast.showToast(message: e.toString().replaceFirst('Exception: ', ''), iserror: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailid.dispose();
    password.dispose();
    super.onClose();
  }
}
