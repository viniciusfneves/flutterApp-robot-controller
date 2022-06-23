import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/data/robot_configs.dart';
import 'package:robot_controller/data/robot_info.dart';
import 'package:robot_controller/data/robot_telemetry.dart';
import 'package:robot_controller/providers/websocket_provider.dart';
import 'package:robot_controller/routes/app_routes.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Providers para decisões do aplicativo
final selectedPage = StateProvider<AppRoutes>((_) => AppRoutes.configuration);
final themeIsDark = StateProvider<bool>((_) => false);

// Providers para conexões
final ws = StateNotifierProvider<WebSocketProvider, WebSocketChannel>(
  (ref) => WebSocketProvider(),
);

final robotConnection = StateProvider(
  (ref) async {
    final connection = ref.watch(ws);
    try {
      await for (final message in connection.stream) {
        Map<String, dynamic> json;
        json = jsonDecode(message as String) as Map<String, dynamic>;
        if (json.containsKey("info")) {
          processJsonInfo(
            json["info"] as Map<String, dynamic>,
            ref,
          );
        }
        if (json.containsKey("configurations")) {
          processJsonConfig(
            json["configurations"] as Map<String, dynamic>,
            ref,
          );
        }
        if (json.containsKey("readings")) {
          processJsonTelemetry(
            json["readings"] as Map<String, dynamic>,
            ref,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  },
);

final robotInfo = StateProvider<RobotInfos>(
  (ref) => RobotInfos(),
);

final robotConfig = StateProvider<RobotConfigs>(
  (ref) => RobotConfigs(),
);
final robotTelemetry = StateProvider<RobotTelemetry>(
  (ref) => RobotTelemetry(),
);
