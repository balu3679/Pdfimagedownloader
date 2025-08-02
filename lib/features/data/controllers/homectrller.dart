import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/domain/repositories/auth.dart';

class Homectrller extends GetxController {
  final _auth = Get.find<Auth>();

  Future<void> logout() async {
    Get.defaultDialog(
      title: "Confirm Logout",
      middleText: "Are you sure you want to log out?",
      textCancel: "Cancel",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await _auth.signOut();
      },
      onCancel: () {},
    );
  }
}
