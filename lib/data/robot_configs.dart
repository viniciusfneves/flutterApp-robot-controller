import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';

class RobotConfigs {
  RobotConfigs({
    this.opReadingInverted,
    this.leftWheelInverted,
    this.rightWheelInverted,
    this.angularAxisInverted,
    this.edgeDetectionThreshold,
    this.opWeight,
    this.startTime,
    this.maxSpeed,
    this.maxSpeedInChase,
    this.rotateAngleBias,
    this.rotateSpeedBias,
    this.arcAngularSpeed,
    this.arcAngle,
    this.arcTimeout,
    this.radarSpeed,
    this.pid,
    this.controller,
    this.mode,
    this.initial,
    this.search,
    this.chase,
  });

  final bool? opReadingInverted;
  final bool? leftWheelInverted;
  final bool? rightWheelInverted;
  final bool? angularAxisInverted;
  final int? startTime;
  final int? maxSpeed;
  final num? edgeDetectionThreshold;
  final Map<String, num?>? opWeight;
  final num? maxSpeedInChase;
  final num? rotateAngleBias;
  final num? rotateSpeedBias;
  final num? arcAngularSpeed;
  final num? arcAngle;
  final num? arcTimeout;
  final num? radarSpeed;
  final PID? pid;
  final Controller? controller;
  final String? mode;
  final String? initial;
  final String? search;
  final String? chase;
}

class PID {
  PID({required this.kp, required this.ki, required this.kd});

  final num? ki;
  final num? kp;
  final num? kd;
}

class Controller {
  Controller(this.commander, this.map, this.filter);

  final String commander;
  final String map;
  final String filter;
}

void processJsonConfig(Map<String, dynamic> newConfig, StateProviderRef ref) {
  final configs = ref.read(robotConfig.notifier);
  final controllerConfigs = newConfig["controller"] as Map<String, dynamic>;
  final pidConfigs = newConfig["pid"] as Map<String, dynamic>;
  final Map<String, num?> weights = {};
  if (newConfig.containsKey("op_sensors_weight")) {
    final Map<String, dynamic> buf = newConfig["op_sensors_weight"] as Map<String, dynamic>;
    buf.forEach((key, value) {
      weights[key] = value as num?;
    });
  }
  configs.update(
    (_) => RobotConfigs(
      opReadingInverted: newConfig["op_reading_inverted"] as bool,
      leftWheelInverted: newConfig["left_wheel_inverted"] as bool,
      rightWheelInverted: newConfig["right_wheel_inverted"] as bool,
      angularAxisInverted: newConfig["angular_axis_inverted"] as bool,
      opWeight: weights,
      maxSpeed: newConfig["max_speed"] as int,
      startTime: newConfig["start_time"] as int,
      edgeDetectionThreshold: newConfig["edge_detection_threshold"] as num,
      maxSpeedInChase: newConfig["max_speed_in_chase"] as num,
      rotateAngleBias: newConfig["rotate_angle_bias"] as num,
      rotateSpeedBias: newConfig["rotate_speed_bias"] as num,
      arcAngularSpeed: newConfig["arc_angular_speed"] as num,
      arcAngle: newConfig["arc_rot_angle"] as num,
      arcTimeout: newConfig["arc_timeout"] as num,
      radarSpeed: newConfig["radar_speed"] as num,
      mode: newConfig["mode"].toString().toUpperCase(),
      initial: newConfig["initial_move"].toString().toUpperCase(),
      search: newConfig["search"].toString().toUpperCase(),
      chase: newConfig["chase"].toString().toUpperCase(),
      controller: Controller(
        controllerConfigs["commander"]! as String,
        controllerConfigs["map"]! as String,
        controllerConfigs["filter"]! as String,
      ),
      pid: PID(
        kp: pidConfigs["kp"] as num?,
        ki: pidConfigs["ki"] as num?,
        kd: pidConfigs["kd"] as num?,
      ),
    ),
  );
}
