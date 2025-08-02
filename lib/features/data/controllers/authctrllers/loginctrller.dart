import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/domain/repositories/auth.dart';
import 'package:todo_app/utils/toast.dart';

class Loginctrller extends GetxController {
  final _authService = Get.find<Auth>();
  final formkey = GlobalKey<FormState>();
  final emailid = TextEditingController(text: 'firstuser@gmail.com');
  final password = TextEditingController(text: '123123123');
  final showpass = Rx<bool>(true);
  final isLoading = false.obs;

  void toggle() {
    showpass.value = !showpass.value;
  }

  Future<void> onsubmit() async {
    try {
      isLoading.value = true;
      final result = await _authService.signInWithEmailPassword(emailid.text, password.text);

      if (result != null) {
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
      Get.snackbar("Error", e.toString());
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
