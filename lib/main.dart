import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/app.dart';
import 'package:todo_app/core/helper.dart';
import 'package:todo_app/domain/repositories/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.init();

  await Hive.initFlutter();
  await Hive.openBox<String>('savedFilesBox');

  Get.put(Auth());
  runApp(const MyApp());
}
