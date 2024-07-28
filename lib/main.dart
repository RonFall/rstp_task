import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'dart:ui';

import 'package:rtsp_task/presentation/screens/rtsp_app_screen.dart';

void main() {
  FlutterError.onError = (details) {
    debugPrint('Flutter error: ${details.exceptionAsString()}');
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Platform error: $error');
    return true;
  };

  ErrorWidget.builder = (details) {
    return const Text(
      'Ошибка при репрезентации UI',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 24),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  runApp(const RtspApp());
}