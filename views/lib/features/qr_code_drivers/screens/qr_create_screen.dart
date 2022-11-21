import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/common/widgets/custom_button_box.dart';
import 'package:scanner/common/widgets/loader.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/constants/padding.dart';
import 'package:scanner/constants/utils.dart';
import 'package:scanner/features/qr_code_drivers/services/qr_code_drivers_service.dart';
import 'package:scanner/features/save_drivers/services/save_driver_service.dart';

class QRCreateScreen extends StatefulWidget {
  static const routeName = 'qr_create_screen';
  final String idDriver;
  const QRCreateScreen({Key? key, required this.idDriver}) : super(key: key);

  @override
  State<QRCreateScreen> createState() => _QRCreateScreenState();
}

class _QRCreateScreenState extends State<QRCreateScreen> {
  QRCodeDriversService _qrCodeDriversService = QRCodeDriversService();
  final qrKey = GlobalKey();
  String? test;
  File? imgFile;

  bool isCharging = false;

  @override
  void initState() {
    // takeScreenShot();
    super.initState();
  }

  void saveDriverQrCode() {
    _qrCodeDriversService.saveDriverQrCode(context, widget.idDriver, test!, () {
      showSnackBar(context, "QRCODE ajouté");
      setState(() {
        isCharging = false;
      });
    });
  }

  void takeScreenShot() async {
    final boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 5.0);

    final byteData = await (image.toByteData(format: ImageByteFormat.png));

    if (byteData != null) {
      final pngBytes = byteData.buffer.asUint8List();
      // test = pngBytes;
      final directory = (await getTemporaryDirectory()).path;
      final imgFile = File(
        '$directory/${DateTime.now()}.png',
      );
      imgFile.writeAsBytes(pngBytes).then((value) => {
            setState(() {
              isCharging = true;
              saveDriverQrCode();
            })
          });
      // GallerySaver.saveImage(imgFile.path).then((success) async {
      //   print("Cool");
      // });

      // imgFile= File.fromRawPath(pngBytes);
      test = imgFile.path;
      print(pngBytes);
      print("OK" + imgFile.path);

      setState(() {});

      // _qrCodeDriversService.saveDriverQrCode(context, widget.idDriver, imgFile.path,
      //     () {
      //   showSnackBar(context, "QRCODE ajouté");
      // });
    }
  }

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("QR Code Generator"),
      ),
      body: isCharging == true
          ? Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RepaintBoundary(
                        key: qrKey,
                        child: QrImage(
                          data: widget.idDriver,
                          size: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      test != null
                          ?
                          // Container(
                          //     width: 50,
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(image: MemoryImage(test!))),
                          //   )

                          Image.file(
                              File(test!),
                              width: 70,
                              height: 150,
                            )
                          : Container(child: Text("Ok")),

                      GestureDetector(
                          onTap: takeScreenShot,
                          child: CustomButtonBox(title: "Sauvegarder QRCODE"))
                      // buildTextField(context)
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.done))),
    );
  }
}
