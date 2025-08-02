import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/domain/repositories/auth.dart';

class SplashController extends GetxController {
  final auth = Get.find<Auth>();

  @override
  void onReady() {
    super.onReady();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is signed out');
        Get.offAllNamed(Routes.login);
      } else {
        print('User is signed in');
        Get.offAllNamed(Routes.home);
      }
    });
  }
}
