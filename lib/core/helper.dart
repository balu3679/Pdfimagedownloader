import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/firebase_options.dart';

class Helper {
  static Future<dynamic> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
