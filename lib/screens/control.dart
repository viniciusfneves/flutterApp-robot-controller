import 'package:blue_app/utils/default_base_screen/default_base_screen.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: Text(
          'Controle',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
