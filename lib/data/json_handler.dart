// TODO: Criar toda a lógica de processamento da mensagem JSON: info, configs e readings
// TODO: Atualizar os providers com as informações recebidas
// ignore_for_file: avoid_dynamic_calls

import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/data/robot_telemetry.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void processJsonInfo(Map<String, dynamic> newInfo, StateProviderRef ref) {
  final infos = ref.read(robotInfo.notifier);
  infos.update(
    (_) => RobotInfos(
      name: newInfo["robot_name"] as String,
      modesAvailable: newInfo["available_modes"] as List<dynamic>,
      initialAvailable:
          newInfo["available_initial_strategies"] as List<dynamic>,
      searchAvailable: newInfo["available_search_strategies"] as List<dynamic>,
      chaseAvailable: newInfo["available_chase_strategies"] as List<dynamic>,
    ),
  );
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
