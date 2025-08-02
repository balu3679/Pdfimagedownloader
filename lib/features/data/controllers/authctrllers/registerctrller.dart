import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/domain/repositories/auth.dart';
import 'package:todo_app/utils/toast.dart';

class RegisterController extends GetxController {
  final _authService = Get.find<Auth>();
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController(text: 'test');
  final emailcontroller = TextEditingController(text: 'firstuser@gmail.com');
  final passwordcontroller = TextEditingController(text: '123123123');
  final confirmcontroller = TextEditingController(text: '123123123');

  final ispassobsure = false.obs;
  final iscpassobsure = false.obs;

  final isloading = false.obs;

  void togglepass() {
    ispassobsure.value = !ispassobsure.value;
  }

  void togglecpass() {
    iscpassobsure.value = !iscpassobsure.value;
  }

  bool isPassWordmatch() {
    return passwordcontroller.text == confirmcontroller.text;
  }

  Future<void> register() async {
    if (!formkey.currentState!.validate()) return;
    isloading.value = true;
    Get.focusScope?.unfocus();
    try {
      final result = await _authService.signUpWithEmailPassword(
        emailcontroller.text.trim(),
        passwordcontroller.text.trim(),
      );
      log('message : $result');
      if (result != null) {
        Toast.showToast(message: 'Registered successfully');
      }
    } catch (e) {
      log('Errrrr : $e');
      log('Errrrr : ${e.toString().replaceFirst('Exception: ', '')}');
      Toast.showToast(message: e.toString().replaceFirst('Exception: ', ''), iserror: true);
    } finally {
      isloading.value = false;
    }
  }
}
