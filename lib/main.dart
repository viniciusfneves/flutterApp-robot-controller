import 'package:blue_app/screen/conection.dart';
import 'package:blue_app/screen/configuration.dart';
import 'package:blue_app/screen/control.dart';
import 'package:blue_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Bluetooth Communication Software",
      theme: ThemeData(primaryColor: Color.fromARGB(255, 160, 25, 25)),
      home: ConectionPage(),
      initialRoute: AppRoutes.Connection,
      routes: {
        AppRoutes.Configuration: (ctx) => ConfigurationPage(),
        AppRoutes.Control: (ctx) => ControlPage(),
      },
    );
  }
}
