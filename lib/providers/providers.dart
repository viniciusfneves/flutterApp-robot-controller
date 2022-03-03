import 'dart:convert';

import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/providers/json_handler.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Providers para decisões do aplicativo
final selectedPage = StateProvider<AppRoutes>((_) => AppRoutes.configuration);
final themeIsDark = StateProvider<bool>((_) => false);

// Providers para conexões
final wsAdress = StateProvider<String>((_) => "");
final ws = StateProvider<WebSocketChannel>(
  (ref) {
    final adress = ref.watch(wsAdress);
    return WebSocketChannel.connect(Uri.parse(adress));
  },
);

final robotDataStream = StateProvider(
  (ref) async {
    final connection = ref.watch(ws);

    await for (final message in connection.stream) {
      Map<String, dynamic> json;
      json = jsonDecode(message as String) as Map<String, dynamic>;
      if (json.containsKey("info")) {
        processJsonInfo(json["info"] as Map<String, dynamic>, ref);
      }
      if (json.containsKey("configurations")) {
        processJsonConfig(json["configurations"] as Map<String, dynamic>, ref);
      }
      if (json.containsKey("readings")) {
        processJsonTelemetry(json);
      }
    }
  },
);

final robotInfo = StateProvider<RobotInfos>(
  (ref) => RobotInfos(
    name: "RobotName",
    modesAvailable: [],
    initialAvailable: [],
    searchAvailable: [],
    chaseAvailable: [],
  ),
);

final robotConfig = StateProvider<RobotConfigs>(
  (ref) => RobotConfigs(
    mode: "",
    initial: "",
    search: "",
    chase: "",
    startTime: 0,
    controller: Controller("commander", "map", "filter"),
    maxSpeed: 0,
    pid: PID(kp: 0, ki: 0, kd: 0),
  ),
);
