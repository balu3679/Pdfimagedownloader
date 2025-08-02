import 'package:get/get.dart';
import 'package:todo_app/domain/repositories/auth.dart';

class Homectrller extends GetxController {
  final _auth = Get.find<Auth>();

  logout() async {
    await _auth.signOut();
  }
}
