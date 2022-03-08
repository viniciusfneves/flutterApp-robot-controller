import 'package:blue_app/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RobotConfigs {
  RobotConfigs({
    this.startTime,
    this.maxSpeed,
    this.maxSpeedInChase,
    this.rotateAngleBias,
    this.rotateSpeedBias,
    this.arcAngularSpeed,
    this.arcAngle,
    this.radarSpeed,
    this.pid,
    this.controller,
    this.mode,
    this.initial,
    this.search,
    this.chase,
  });

  final int? startTime;
  final int? maxSpeed;
  final num? maxSpeedInChase;
  final num? rotateAngleBias;
  final num? rotateSpeedBias;
  final num? arcAngularSpeed;
  final num? arcAngle;
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

  final num ki;
  final num kp;
  final num kd;
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
  configs.update(
    (_) => RobotConfigs(
      maxSpeed: newConfig["max_speed"] as int,
      maxSpeedInChase: newConfig["max_speed_in_chase"] as num,
      rotateAngleBias: newConfig["rotate_angle_bias"] as num,
      rotateSpeedBias: newConfig["rotate_speed_bias"] as num,
      arcAngularSpeed: newConfig["arc_angular_speed"] as num,
      arcAngle: newConfig["arc_rot_initial_angle"] as num,
      radarSpeed: newConfig["radar_speed"] as num,
      startTime: newConfig["start_time"] as int,
      mode: newConfig["mode"].toString().toUpperCase(),
      initial: newConfig["initial_move"].toString().toUpperCase(),
      search: newConfig["search"].toString().toUpperCase(),
      chase: newConfig["chase"].toString().toUpperCase(),
      controller: Controller(
        controllerConfigs["commander"]! as String,
        controllerConfigs["mapping"]! as String,
        controllerConfigs["filter"]! as String,
      ),
      pid: PID(
        kp: pidConfigs["kp"]! as num,
        ki: pidConfigs["ki"]! as num,
        kd: pidConfigs["kd"]! as num,
      ),
    ),
  );
}
