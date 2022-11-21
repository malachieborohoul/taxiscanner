import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scanner/common/widgets/loader.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/constants/padding.dart';
import 'package:scanner/models/driver.dart';

class QRDriverInfoScreen extends StatefulWidget {
  static const routeName = "qr_driver_info_screen";

  final List<Driver> driver;
  const QRDriverInfoScreen({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  State<QRDriverInfoScreen> createState() => _QRDriverInfoScreenState();
}

class _QRDriverInfoScreenState extends State<QRDriverInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          "Informations du chauffeur",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.driver.isEmpty? Center(child: Text('Aucune donné')): Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.driver[0].photo,
                      ),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    border: Border.all(color: primary, width: 5.0)),
              ),
              SizedBox(height: 15),
              Text("Nom et Prenom",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(height: 15),
              Text(widget.driver[0].nom + " " + widget.driver[0].prenom,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              SizedBox(height: 15),
              Text("Code",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(height: 15),
              Text(widget.driver[0].codeChauffeur,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              SizedBox(height: 15),
              Text("Numero d'imatriculation",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(height: 15),
              Text(widget.driver[0].numeroIm,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              SizedBox(height: 15),
              Container(
                
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // gradient: LinearGradient(
                    //     colors: [primary, Colors.blue, Colors.red]),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: primary, width: 5.0),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          widget.driver[0].qrImage,
                        ))),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
