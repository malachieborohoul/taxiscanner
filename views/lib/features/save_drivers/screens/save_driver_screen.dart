import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner/common/widgets/custom_button_box.dart';
import 'package:scanner/common/widgets/custom_textfield.dart';
import 'package:scanner/common/widgets/loader.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/constants/padding.dart';
import 'package:scanner/constants/utils.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_create_screen.dart';
import 'package:scanner/features/save_drivers/services/save_driver_service.dart';

class SaveDriversScreen extends StatefulWidget {
  static const routeName = "save_driver_screen";
  const SaveDriversScreen({Key? key}) : super(key: key);

  @override
  State<SaveDriversScreen> createState() => _SaveDriversScreenState();
}

class _SaveDriversScreenState extends State<SaveDriversScreen> {
  XFile? _file;
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController codeChauffeurController = TextEditingController();
  TextEditingController numeroImController = TextEditingController();
  SaveDriverService saveDriverService = SaveDriverService();
  bool isCharging = false;

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    codeChauffeurController.dispose();
    numeroImController.dispose();
    super.dispose();
  }

  final _saveDriverFormKey = GlobalKey<FormState>();

  String returnedDriverId = "";

  void saveDriver() async {
    returnedDriverId = await saveDriverService.saveDriver(
      context,
      nomController.text,
      prenomController.text,
      codeChauffeurController.text,
      numeroImController.text,
      _file!.path,
    );

    setState(() {
      isCharging = false;
      _file = null;
      nomController.text = "";
      prenomController.text = "";
      codeChauffeurController.text = "";
      numeroImController.text = "";
      // showSnackBar(context, "Chauffeur ajouté avec succès: " + returnedDriverId);

      Navigator.pushNamed(context, QRCreateScreen.routeName, arguments: returnedDriverId);
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Choisir une image"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Prendre une photo"),
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Choisir à partir de la galerie"),
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black
          
        ),
        body: isCharging == true
            ? Loader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(appPadding),
                  child: Form(
                    key: _saveDriverFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            _file != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(_file!.path),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: primary.withOpacity(0.2)),
                                  ),
                            Positioned(
                              child: IconButton(
                                onPressed: () => _selectImage(context),
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: appPadding,
                        ),
                        CustomTextField(
                          labelText: "Nom",
                          controller: nomController,
                        ),
                        const SizedBox(
                          height: appPadding,
                        ),
                        CustomTextField(
                          labelText: "Prenom",
                          controller: prenomController,
                        ),
                        const SizedBox(
                          height: appPadding,
                        ),
                        CustomTextField(
                            labelText: "Code du chauffeur",
                            controller: codeChauffeurController),
                        const SizedBox(
                          height: appPadding,
                        ),
                        CustomTextField(
                            labelText: "Numero d'immatriculation",
                            controller: numeroImController),
                        const SizedBox(
                          height: appPadding,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_saveDriverFormKey.currentState!.validate()) {
                              if (_file != null) {
                                setState(() {
                                  isCharging = true;
                                  saveDriver();
                                });
                              } else {
                                showSnackBar(context,
                                    "Ajouter une photo avant de continuer");
                              }
                            }
                          },
                          child: const CustomButtonBox(
                              title: "Enregistrer chauffeur"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
