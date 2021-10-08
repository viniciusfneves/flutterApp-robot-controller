import 'package:flutter/material.dart';

class RobotData extends ChangeNotifier {
  int startTime = 0;
  int maxSpeed = 255;
  int availableOpSensors = 0;
  int availableEdgeSensors = 0;
  String modeConfiguration = 'unknown';
  String initialMoveConfiguration = 'unknown';
  String searchConfiguration = 'unknown';
  String chaseConfiguration = 'unknown';
  Map<String, num> pidConfiguration = {
    "kp": 0,
    "ki": 0,
    "kd": 0,
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
  Map<String, int> powerOnWheels = {
    "left-motor": 0,
    "right-motor": 0,
  };

  setStartTime(int time) {
    startTime = time;
    notifyListeners();
  }

  setMaxSpeed(int speed) {
    maxSpeed = speed;
    notifyListeners();
  }

  setPID(num kp, num ki, num kd) {
    pidConfiguration["kp"] = kp;
    pidConfiguration["ki"] = ki;
    pidConfiguration["kd"] = kd;
    notifyListeners();
  }

  setMode(String mode) {
    modeConfiguration = mode;
    notifyListeners();
  }

  setInitialMove(String move) {
    initialMoveConfiguration = move;
    notifyListeners();
  }

  setSearch(String search) {
    searchConfiguration = search;
    notifyListeners();
  }

  setChase(String chase) {
    chaseConfiguration = chase;
    notifyListeners();
  }

  setAvailableOP(int availableSensors) {
    availableOpSensors = availableSensors;
  }

  setAvailableEdge(int availableSensors) {
    availableEdgeSensors = availableSensors;
  }

  setOpponentSensors(List<dynamic> detectionArray) {
    if (availableOpSensors == 2) {
      opSensorDetectionArray['left'] = detectionArray[0];
      opSensorDetectionArray['right'] = detectionArray[1];
    }
    if (availableOpSensors == 3) {
      opSensorDetectionArray['left'] = detectionArray[0];
      opSensorDetectionArray['center'] = detectionArray[1];
      opSensorDetectionArray['right'] = detectionArray[2];
    }
    if (availableOpSensors == 5) {
      opSensorDetectionArray['far-left'] = detectionArray[0];
      opSensorDetectionArray['left'] = detectionArray[1];
      opSensorDetectionArray['center'] = detectionArray[2];
      opSensorDetectionArray['right'] = detectionArray[3];
      opSensorDetectionArray['far-right'] = detectionArray[4];
    }
    if (availableOpSensors == 7) {
      opSensorDetectionArray['left-side'] = detectionArray[0];
      opSensorDetectionArray['far-left'] = detectionArray[1];
      opSensorDetectionArray['left'] = detectionArray[2];
      opSensorDetectionArray['center'] = detectionArray[3];
      opSensorDetectionArray['right'] = detectionArray[4];
      opSensorDetectionArray['far-right'] = detectionArray[5];
      opSensorDetectionArray['right-side'] = detectionArray[6];
    }
    notifyListeners();
  }

  setEdgeSensors(List<dynamic> detectionArray) {
    if (availableEdgeSensors == 2) {
      edgeSensorDetectionArray['front-left'] = detectionArray[0];
      edgeSensorDetectionArray['front-right'] = detectionArray[1];
    }
    if (availableEdgeSensors == 4) {
      edgeSensorDetectionArray['front-left'] = detectionArray[0];
      edgeSensorDetectionArray['front-right'] = detectionArray[1];
      edgeSensorDetectionArray['rear-left'] = detectionArray[2];
      edgeSensorDetectionArray['rear-right'] = detectionArray[3];
    }
    notifyListeners();
  }

  setWheelPower(int leftWheel, int rightWheel) {
    powerOnWheels['left-motor'] = leftWheel;
    powerOnWheels['right-motor'] = rightWheel;
    notifyListeners();
  }
}
