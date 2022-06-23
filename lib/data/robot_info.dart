import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';

class RobotInfos {
  RobotInfos({
    this.isConnected = false,
    this.name,
    this.category,
    this.modesAvailable,
    this.initialAvailable,
    this.searchAvailable,
    this.chaseAvailable,
    this.ctrlTypeAvailable,
    this.ctrlMapAvailable,
    this.ctrlFilterAvailable,
  });

  final bool isConnected;
  final String? name;
  final String? category;
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
      isConnected: true,
      category: newInfo.containsKey("category")
          ? newInfo["category"] as String
          : null,
      modesAvailable: newInfo.containsKey("available_modes")
          ? newInfo["available_modes"] as List<dynamic>
          : null,
      initialAvailable: newInfo.containsKey("available_initial_strategies")
          ? newInfo["available_initial_strategies"] as List<dynamic>
          : null,
      searchAvailable: newInfo.containsKey("available_search_strategies")
          ? newInfo["available_search_strategies"] as List<dynamic>
          : null,
      chaseAvailable: newInfo.containsKey("available_chase_strategies")
          ? newInfo["available_chase_strategies"] as List<dynamic>
          : null,
      ctrlTypeAvailable: newInfo.containsKey("available_ctrl_types")
          ? newInfo["available_ctrl_types"] as List<dynamic>
          : null,
      ctrlMapAvailable: newInfo.containsKey("available_ctrl_maps")
          ? newInfo["available_ctrl_maps"] as List<dynamic>
          : null,
      ctrlFilterAvailable: newInfo.containsKey("available_ctrl_filters")
          ? newInfo["available_ctrl_filters"] as List<dynamic>
          : null,
    ),
  );
}
