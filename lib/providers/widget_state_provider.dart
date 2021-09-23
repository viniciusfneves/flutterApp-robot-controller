import 'package:flutter/material.dart';

class WidgetState extends ChangeNotifier {
  String mainAppTitle = 'MinervApp';
  String robotStateText = 'Unknown';
  Color robotStateCircle = Colors.blueGrey;

  void setReadyState() {
    robotStateText = 'Ready';
    robotStateCircle = Colors.yellow[800];
    notifyListeners();
  }

  void setFightState() {
    robotStateText = 'Fighting';
    robotStateCircle = Colors.green[800];
    notifyListeners();
  }

  void setDisabledState() {
    robotStateText = 'Disabled';
    robotStateCircle = Colors.red[900];
    notifyListeners();
  }

  void addRobotNameToAppTitle(String robotName) {
    mainAppTitle = 'MinervApp - $robotName';
    notifyListeners();
  }
}
