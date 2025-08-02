import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/data/controllers/authctrllers/splashctrller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController splashController;
  @override
  void initState() {
    splashController = Get.put(SplashController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Or your logo/animation
      ),
    );
  }
}
