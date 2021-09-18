import 'package:blue_app/screens/connection.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/control.dart';
import 'package:blue_app/app_controller/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Wi-Fi Controller Software",
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
