import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<bool> requestSmartPermission() async {
  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    if (sdkInt <= 29) {
      print('*******');
      // Android 10 and below
      final readStatus = await Permission.storage.request();
      return readStatus.isGranted;
    } else if (sdkInt >= 33) {
      final statuses = await [Permission.photos, Permission.videos, Permission.audio].request();
      return statuses.values.every((s) => s.isGranted);
    }
  }

  return true;
}
