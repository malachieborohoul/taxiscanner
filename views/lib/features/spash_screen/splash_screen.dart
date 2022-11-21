import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/features/home/screens/home_screen.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_driver_info_screen.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_scan_screen.dart';
import 'package:scanner/features/save_drivers/screens/save_driver_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TAXISCAN",
                style: TextStyle(
                    fontSize: 60, color: primary, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(
              color: primary,
            )
          ],
        ),
      ),
    );
  }
}
