// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'package:blue_app/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RobotTelemetry {
  RobotTelemetry({
    this.executionStatus,
    this.leftMotor,
    this.rightMotor,
    this.OPleftSide = false,
    this.OPfarLeft = false,
    this.OPleft = false,
    this.OPcenter = false,
    this.OPright = false,
    this.OPfarRight = false,
    this.OPrightSide = false,
    this.EDGEfrontLeft = false,
    this.EDGEfrontRight = false,
    this.EDGErearLeft = false,
    this.EDGErearRight = false,
  });

  final String? executionStatus;
  final int? leftMotor;
  final int? rightMotor;
  final bool OPleftSide;
  final bool OPfarLeft;
  final bool OPleft;
  final bool OPcenter;
  final bool OPright;
  final bool OPfarRight;
  final bool OPrightSide;
  final bool EDGEfrontLeft;
  final bool EDGEfrontRight;
  final bool EDGErearLeft;
  final bool EDGErearRight;
}

void processJsonTelemetry(Map<String, dynamic> newData, StateProviderRef ref) {
  final data = ref.read(robotTelemetry.notifier);
  final opSensors = newData["opponent"];
  final edgeSensors = newData["edge"];
  final motors = newData["motor"];

  data.update(
    (_) => RobotTelemetry(
      executionStatus: newData["robot_status"] as String,
      OPfarLeft: opSensors[0]! as bool,
      OPleft: opSensors[1]! as bool,
      OPcenter: opSensors[2]! as bool,
      OPright: opSensors[3]! as bool,
      OPfarRight: opSensors[4]! as bool,
      EDGEfrontLeft: edgeSensors[0]! as bool,
      EDGEfrontRight: edgeSensors[1]! as bool,
      leftMotor: motors[0]! as int,
      rightMotor: motors[1]! as int,
    ),
  );
}
