import 'package:blue_app/screens/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class AdvancedControllerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: Text(
          'Controle Avançado',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
