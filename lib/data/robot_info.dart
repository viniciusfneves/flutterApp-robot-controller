import 'package:blue_app/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RobotInfos {
  RobotInfos({
    this.name,
    this.modesAvailable,
    this.initialAvailable,
    this.searchAvailable,
    this.chaseAvailable,
  });

  final String? name;
  final List<dynamic>? modesAvailable;
  final List<dynamic>? initialAvailable;
  final List<dynamic>? searchAvailable;
  final List<dynamic>? chaseAvailable;
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
    ),
  );
}
