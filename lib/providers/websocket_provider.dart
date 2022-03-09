import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider extends StateNotifier<WebSocketChannel> {
  String adress = "ws://192.168.4.1:81";
  WebSocketProvider()
      : super(WebSocketChannel.connect(Uri.parse("ws://192.168.4.1:81")));

  void changeConnectionAdress(String newAdress) {
    state.sink.close();
    adress = newAdress;
    state = WebSocketChannel.connect(Uri.parse(newAdress));
  }

  void sendMessage(String message) {
    state.sink.add(message);
  }
}
