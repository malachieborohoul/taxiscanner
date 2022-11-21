import 'dart:convert';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scanner/constants/error_handling.dart';
import 'package:scanner/constants/global.dart';
import 'package:scanner/constants/utils.dart';

class SaveDriverService {
  Future<String> saveDriver(
      BuildContext context,
      String nom,
      String prenom,
      String codeChauffeur,
      String numeroIm,
      String image,
      ) async {
      late String idDriver;

    try {
      final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
      String imageUrl;

      CloudinaryResponse resIm = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image, folder: nom.toLowerCase()));
      imageUrl = resIm.secureUrl;

      http.Response res = await http.post(
        Uri.parse('$uri/add-driver'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'nom': nom,
            'prenom': prenom,
            'codeChauffeur': codeChauffeur,
            'numeroIm': numeroIm,
            'photo': imageUrl,
          },
        ),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            idDriver = jsonDecode(res.body);
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return idDriver;
  }
}
