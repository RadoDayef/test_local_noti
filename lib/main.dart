import 'package:flutter/material.dart';
import 'package:test_local_noti/noti_controller.dart';
import 'package:test_local_noti/test_local_noti_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotiController.init();
  runApp(TestLocalNotiApp());
}
