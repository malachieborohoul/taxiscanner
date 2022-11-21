import 'dart:convert';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scanner/constants/error_handling.dart';
import 'package:scanner/constants/global.dart';
import 'package:scanner/constants/utils.dart';
import 'package:scanner/models/driver.dart';

class QRCodeDriversService {
  Future<void> saveDriverQrCode(BuildContext context, String id, String qrImage,
      VoidCallback success) async {
    try {
      final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
      String imageUrl;

      CloudinaryResponse resIm = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(qrImage, folder: id.toLowerCase()));
      imageUrl = resIm.secureUrl;

      http.Response res = await http.post(
        Uri.parse('$uri/save-driver-qrcode'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'idDriver': id,
            'qrImage': imageUrl,
          },
        ),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            success();
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Driver> isDriverExist(BuildContext context, String? idDriver) async {
    late Driver driver;

    try {
      http.Response res = await http.post(Uri.parse("$uri/id-driver-exist"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "idDriver": idDriver,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          driver = Driver.fromJson(res.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return driver;
  }
}
