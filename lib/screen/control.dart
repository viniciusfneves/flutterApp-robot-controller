import 'package:blue_app/utils/screen_base.dart';
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
