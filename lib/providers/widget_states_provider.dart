import 'package:flutter/material.dart';

class RobotWidgetState extends ChangeNotifier {
  Color readystate = Colors.red;
  Color fightstate = Colors.red;
  Color disabledstate = Colors.red;

  void setReadyState() {
    readystate = Colors.green;
    fightstate = Colors.blueGrey;
    disabledstate = Colors.blueGrey;
    notifyListeners();
  }

  void setFightState() {
    readystate = Colors.blueGrey;
    fightstate = Colors.green;
    disabledstate = Colors.blueGrey;
    notifyListeners();
  }

  void setDisabledState() {
    readystate = Colors.blueGrey;
    fightstate = Colors.blueGrey;
    disabledstate = Colors.green;
    notifyListeners();
  }
}
