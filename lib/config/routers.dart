import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/features/presentation/pages/auth/login.dart';
import 'package:todo_app/features/presentation/pages/auth/register.dart';
import 'package:todo_app/features/presentation/pages/auth/splash.dart';
import 'package:todo_app/features/presentation/pages/home.dart';
import 'package:todo_app/features/presentation/pages/previewscreen.dart';

class Routers {
  static final router = [
    GetPage(name: Routes.splash, page: () => SplashPage()),
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.register, page: () => RegisterPage()),
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.preview, page: () => FilePreviewScreen()),
  ];
}
