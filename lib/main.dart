import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/app.dart';
import 'package:todo_app/core/helper.dart';
import 'package:todo_app/domain/repositories/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.init();
  Get.put(Auth());
  runApp(const MyApp());
}
