import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/constants/padding.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_create_screen.dart';
import 'package:scanner/features/save_drivers/screens/save_driver_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: primary.withOpacity(0.2),
              ),
              SizedBox(
                height: appPadding,
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              SizedBox(
                height: appPadding,
              ),
              Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text("Générer un QRCode",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    onTap: () {
                      Navigator.pushNamed(context, SaveDriversScreen.routeName);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
