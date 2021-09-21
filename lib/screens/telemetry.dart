import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: Text(
          'Telemetria',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
