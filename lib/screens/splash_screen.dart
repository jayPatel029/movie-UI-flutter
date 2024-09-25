import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_api_quad/screens/bottom_nav.dart';

import '../utils/images.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNav()));
    });
  }

  Map<String, dynamic>? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              app_logo,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
