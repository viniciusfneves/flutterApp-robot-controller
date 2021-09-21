import 'package:http/http.dart' as http;

void sendControllerCommand(double linear, double angular) async {
  final response = await http.post(Uri.parse('http://192.168.4.1/controller'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: '{"controller":{"linearSpeed":$linear,"angularSpeed":$angular}}');

  if (response.statusCode == 200) {
    // Se o server enviar status 200, então tudo OK
  } else {
    // Se o server enviar status 200, então houve algum erro
    print("bad");
  }
}
