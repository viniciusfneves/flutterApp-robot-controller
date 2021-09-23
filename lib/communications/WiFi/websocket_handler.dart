import 'package:web_socket_channel/web_socket_channel.dart';

final websocket = WebSocketChannel.connect(
  Uri.parse('ws://192.168.4.1:81'),
);

final websocketData = websocket.stream.asBroadcastStream();
