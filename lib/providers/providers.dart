import 'dart:convert';

import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/providers/json_handler.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Providers para decisões do aplicativo
final selectedPage = StateProvider<AppRoutes>((_) => AppRoutes.configuration);
final themeIsDark = StateProvider<bool>((_) => false);

// Providers para conexões
final wsAdress = StateProvider<String>((_) => "ws://192.168.4.1:81");
final ws = StateProvider<WebSocketChannel>(
  (ref) {
    final adress = ref.watch(wsAdress);
    return WebSocketChannel.connect(Uri.parse(adress));
  },
);

final robotConnection = StateProvider(
  (ref) async {
    final connection = ref.watch(ws);
    try {
      await for (final message in connection.stream) {
        Map<String, dynamic> json;
        json = jsonDecode(message as String) as Map<String, dynamic>;
        if (json.containsKey("info")) {
          processJsonInfo(json["info"] as Map<String, dynamic>, ref);
        }
        if (json.containsKey("configurations")) {
          processJsonConfig(
            json["configurations"] as Map<String, dynamic>,
            ref,
          );
        }
        if (json.containsKey("readings")) {
          processJsonTelemetry(json);
        }
      }
    } on WebSocketChannelException {
      debugPrint("Timeout de Conexão WebSocket");
      ref.read(robotConfig.notifier).update((state) => RobotConfigs());
      ref.read(robotInfo.notifier).update((state) => RobotInfos());
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
