import 'dart:convert';

import 'package:blue_app/data/robot_configs.dart';
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

final robotDataStream = StreamProvider<Map<String, dynamic>>(
  (ref) async* {
    final connection = ref.watch(ws);

    await for (final message in connection.stream) {
      Map<String, dynamic> json;
      json = jsonDecode(message as String) as Map<String, dynamic>;
      yield json;
    }
  },
);

final robotConfig = StateProvider<RobotConfigs>(
  (ref) => RobotConfigs(
    mode: "",
    initial: "",
    search: "",
    chase: "",
  ),
);
