import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';

class RobotInfos {
  RobotInfos({
    this.name,
    this.modesAvailable,
    this.initialAvailable,
    this.searchAvailable,
    this.chaseAvailable,
    this.ctrlTypeAvailable,
    this.ctrlMapAvailable,
    this.ctrlFilterAvailable,
  });

  final String? name;
  final List<dynamic>? modesAvailable;
  final List<dynamic>? initialAvailable;
  final List<dynamic>? searchAvailable;
  final List<dynamic>? chaseAvailable;
  final List<dynamic>? ctrlTypeAvailable;
  final List<dynamic>? ctrlMapAvailable;
  final List<dynamic>? ctrlFilterAvailable;
}

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
      ctrlTypeAvailable: newInfo["available_ctrl_types"] as List<dynamic>,
      ctrlMapAvailable: newInfo["available_ctrl_maps"] as List<dynamic>,
      ctrlFilterAvailable: newInfo["available_ctrl_filters"] as List<dynamic>,
    ),
  );
}
