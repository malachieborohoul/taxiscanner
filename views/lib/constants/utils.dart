import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    print(_file.readAsBytes());
    
    return _file;
  }

  print('Pas d"image');
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text)));
}



