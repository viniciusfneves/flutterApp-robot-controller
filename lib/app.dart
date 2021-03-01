import 'package:blue_app/screens/connection.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/control.dart';
import 'package:blue_app/app_controller/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/app_controller/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: MaterialAppWithThemeController(),
    );
  }
}

class MaterialAppWithThemeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeMode currentTheme = Provider.of<ThemeController>(context).appTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Bluetooth Communication Software",
      theme: ThemeData(primaryColor: Color.fromARGB(255, 160, 25, 25)),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme,
      home: ConectionPage(),
      initialRoute: AppRoutes.Connection,
      routes: {
        AppRoutes.Configuration: (ctx) => ConfigurationPage(),
        AppRoutes.Control: (ctx) => ControlPage(),
      },
    );
  }
}
