import 'package:flutter/material.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_scan_screen.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_create_screen.dart';
import 'package:scanner/features/save_drivers/screens/save_driver_screen.dart';
import 'package:scanner/router.dart';

import 'features/spash_screen/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: (setting) => generateRoute(setting),
  ));
}

