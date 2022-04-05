// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'package:blue_app/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RobotTelemetry {
  RobotTelemetry({
    this.executionStatus,
    this.leftMotor,
    this.rightMotor,
    this.OPleftSide,
    this.OPfarLeft,
    this.OPleft,
    this.OPcenter,
    this.OPright,
    this.OPfarRight,
    this.OPrightSide,
    this.EDGEfrontLeft,
    this.EDGEfrontRight,
    this.EDGErearLeft,
    this.EDGErearRight,
  });

  final String? executionStatus;
  final int? leftMotor;
  final int? rightMotor;
  final bool? OPleftSide;
  final bool? OPfarLeft;
  final bool? OPleft;
  final bool? OPcenter;
  final bool? OPright;
  final bool? OPfarRight;
  final bool? OPrightSide;
  final bool? EDGEfrontLeft;
  final bool? EDGEfrontRight;
  final bool? EDGErearLeft;
  final bool? EDGErearRight;
}

void processJsonTelemetry(Map<String, dynamic> newData, StateProviderRef ref) {
  final data = ref.read(robotTelemetry.notifier);
  final opSensors = newData.containsKey("opponent")
      ? newData["opponent"] as Map<String, dynamic>
      : {};
  final edgeSensors = newData.containsKey("edge")
      ? newData["edge"] as Map<String, dynamic>
      : {};
  final motors = newData["motor"];

  data.update(
    (_) => RobotTelemetry(
      executionStatus: newData["robot_status"] as String,
      OPleftSide: opSensors.containsKey("leftSide")
          ? opSensors["leftSide"] as bool
          : null,
      OPfarLeft: opSensors.containsKey("farLeft")
          ? opSensors["farLeft"] as bool
          : null,
      OPleft: opSensors.containsKey("left") ? opSensors["left"] as bool : null,
      OPcenter:
          opSensors.containsKey("center") ? opSensors["center"] as bool : null,
      OPright:
          opSensors.containsKey("right") ? opSensors["right"] as bool : null,
      OPfarRight: opSensors.containsKey("farRight")
          ? opSensors["farRight"] as bool
          : null,
      OPrightSide: opSensors.containsKey("rightSide")
          ? opSensors["rightSide"] as bool
          : null,
      EDGEfrontLeft: edgeSensors.containsKey("frontLeft")
          ? edgeSensors["frontLeft"] as bool
          : null,
      EDGEfrontRight: edgeSensors.containsKey("frontRight")
          ? edgeSensors["frontRight"] as bool
          : null,
      EDGErearLeft: edgeSensors.containsKey("rearLeft")
          ? edgeSensors["rearLeft"] as bool
          : null,
      EDGErearRight: edgeSensors.containsKey("rearRight")
          ? edgeSensors["rearRight"] as bool
          : null,
      leftMotor: motors[0] as int?,
      rightMotor: motors[1] as int?,
    ),
  );
}
