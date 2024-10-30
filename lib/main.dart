import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_api_quad/screens/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      backgroundColor: Colors.grey,
      enabled: kDebugMode,
      defaultDevice: Devices.android.mediumPhone,
      isToolbarVisible: true,
      availableLocales: const [Locale('en', "US")],
      tools: const [
        DeviceSection(
          model: true,
          orientation: false,
          frameVisibility: false,
          virtualKeyboard: false,
        ),
      ],
      builder: (context) => MyApp(),
    ),

    // MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // const BottomNav(),
    );
  }
}
