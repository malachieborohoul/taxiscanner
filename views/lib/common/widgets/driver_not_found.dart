import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scanner/constants/utils.dart';

class DriverNotFound extends StatelessWidget {
  const DriverNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(assetImg+'taxi.png'),
            Text("Aucunes données trouvées", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }
}
