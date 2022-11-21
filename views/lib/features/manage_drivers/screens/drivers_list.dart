import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scanner/constants/padding.dart';
import 'package:scanner/models/driver.dart';

class DriversList extends StatefulWidget {
  static const routeName = "driver-list";
  const DriversList({Key? key}) : super(key: key);

  @override
  State<DriversList> createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  List<Driver> listDrivers = [];
  @override
  void initState() {
    super.initState();
  }

  void getAllDrivers() async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, i) {
              return Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BSM",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ddbdbkbd",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
