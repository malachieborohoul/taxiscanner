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

class ManageDriversService {
 

  Future<List<Driver>> getAllDrivers(
      BuildContext context, String? idDriver) async {
    List<Driver> driversList = [];

    try {
      http.Response res = await http.get(Uri.parse("$uri/get-all-drivers"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
         
          );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
           for (int i = 0; i < jsonDecode(res.body).length; i++) {
              driversList.add(
                Driver.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return driversList;
  }
}
