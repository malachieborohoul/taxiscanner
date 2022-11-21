import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scanner/common/widgets/navigation_drawer.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            backgroundColor: Colors.white60,
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: NavigationDrawer(),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () {
                Navigator.pushNamed(context, QRScanScreen.routeName);
              },
              child: Ink(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.qr_code_scanner_outlined, color: Colors.white),
                    Text("Scanner un QRcode",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
