<<<<<<< HEAD
import 'package:blue_app/screens/screen_template/screen_template.dart';
=======
import 'package:blue_app/screens/default_screen/default_screen.dart';
>>>>>>> develop
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
