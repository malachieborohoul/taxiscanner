import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/common/widgets/loader.dart';
import 'package:scanner/constants/utils.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_driver_info_screen.dart';
import 'package:scanner/features/qr_code_drivers/services/qr_code_drivers_service.dart';
import 'package:scanner/models/driver.dart';

class QRScanScreen extends StatefulWidget {
  static const routeName = "qr_scan_screen";
  const QRScanScreen({Key? key}) : super(key: key);

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final qrKey = GlobalKey(debugLabel: "QR");

  List<Driver> driver=[];

  bool isCharging = false;

  QRCodeDriversService _qrCodeDriversService = QRCodeDriversService();

  Barcode? barcode;
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void checkDriverExist() async {
    driver = await _qrCodeDriversService.isDriverExist(context, barcode!.code);
    setState(() {
      isCharging = false;

      Navigator.pushNamed(context, QRDriverInfoScreen.routeName,
          arguments: driver);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isCharging == true
          ? Loader()
          : Stack(
              alignment: Alignment.center,
              children: [
                buildQrView(context),
                Positioned(
                  bottom: 10,
                  child: buildResult(),
                ),
                Positioned(
                  top: 10,
                  child: buildControlButtons(),
                )
              ],
            ),
    ));
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.greenAccent,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 20,
          borderLength: 10),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      return setState(() {
        this.barcode = barcode;

        checkDriverExist();
        isCharging = true;
      });
    });
  }

  Widget buildResult() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Text(
        // barcode != null ? "Result : ${barcode!.code}" : 'Scanner un CodeQr',
        'Scanner un QRcode',
        maxLines: 3,
      ),
    );
  }

  Widget buildControlButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off);
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(Icons.switch_camera);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
