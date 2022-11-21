import 'package:flutter/material.dart';
import 'package:scanner/features/home/screens/home_screen.dart';
import 'package:scanner/features/manage_drivers/screens/drivers_list.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_create_screen.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_driver_info_screen.dart';
import 'package:scanner/features/qr_code_drivers/screens/qr_scan_screen.dart';
import 'package:scanner/features/save_drivers/screens/save_driver_screen.dart';
import 'package:scanner/models/driver.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SaveDriversScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SaveDriversScreen());
    case QRCreateScreen.routeName:
          var idDriver = routeSettings.arguments as String;

      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  QRCreateScreen(idDriver: idDriver,));
 
    case QRScanScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const QRScanScreen());
   
    case QRDriverInfoScreen.routeName:
          var driver = routeSettings.arguments as List<Driver>;

      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  QRDriverInfoScreen(driver: driver,));
 
     case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    
     case DriversList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const DriversList());
   
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("ERREUR 404"),
                ),
              ));
  }
}
