import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/telemetry.dart';
import 'package:blue_app/screens/advanced_controller.dart';
import 'package:blue_app/screens/control.dart';
import 'package:blue_app/app_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
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
