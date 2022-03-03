// TODO: Criar toda a lógica de processamento da mensagem JSON: info, configs e readings
// TODO: Atualizar os providers com as informações recebidas
import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void processJsonInfo(Map<String, dynamic> newInfo, StateProviderRef ref) {
  print(newInfo);
  final infos = ref.read(robotInfo.notifier);
  infos.update(
    (state) => RobotInfos(
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
    (state) => RobotConfigs(
      maxSpeed: newConfig["max_speed"] as int,
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

void processJsonTelemetry(Map<String, dynamic> json) {}
