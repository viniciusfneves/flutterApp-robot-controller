import 'dart:convert';
import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/telemetry.dart';
import 'package:blue_app/screens/advanced_controller.dart';
import 'package:blue_app/screens/control.dart';
import 'package:blue_app/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'communications/WiFi/websocket_handler.dart';
import 'communications/json/json_handler.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    websocketData.listen((data) {
      Map<String, dynamic> json = jsonDecode(data);
      processJsonMessage(context, json);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Wi-Fi Controller Software",
      initialRoute: AppRoutes.Configuration,
      home: ConfigurationPage(),
      routes: {
        AppRoutes.Telemetry: (ctx) => TelemetryPage(),
        AppRoutes.Control: (ctx) => ControlPage(),
        AppRoutes.AdvancedControl: (ctx) => AdvancedControllerPage(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RobotData()),
      ChangeNotifierProvider(create: (_) => WidgetState()),
    ],
    child: MyApp(),
  ));
}
