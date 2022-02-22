import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel ws = WebSocketChannel.connect(
  Uri.parse('ws://192.168.1.17:81'),
);

StreamSubscription robotStream = ws.stream.listen((data) {
  Map<String, dynamic> json;
  json = jsonDecode(data as String) as Map<String, dynamic>;
  debugPrint(json as String);
});
