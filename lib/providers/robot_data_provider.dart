import 'package:flutter/material.dart';

class RobotData extends ChangeNotifier {
  String robotName = 'unknown';
  String robotState = 'unknown';
  double maxSpeed = 255;
  String initialMoveConfiguration = 'unknown';
  String searchConfiguration = 'unknown';
  String chaseConfiguration = 'unknown';
  Map<String, double> pidConfiguration = {
    "kp": 0,
    "ki": 0,
    "kd": 0,
  };
  Map<String, int> startTimeConfiguration = {
    "p": 0,
    "i": 0,
    "d": 0,
  };
  Map<String, bool> opSensorDetectionArray = {
    "left-side": false,
    "far-left": false,
    "left": false,
    "center": false,
    "right": false,
    "far-right": false,
    "right-side": false,
  };
  Map<String, bool> edgeSensorDetectionArray = {
    "front-left": false,
    "front-right": false,
    "rear-left": false,
    "rear-right": false,
  };
  Map<String, bool> powerOnWheels = {
    "left-motor": false,
    "right-motor": false,
  };
}
