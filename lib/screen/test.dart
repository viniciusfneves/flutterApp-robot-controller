import 'package:blue_app/utils/bluetooth.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Bluetooth blue = Bluetooth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: blue.deviceScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return (Container(child: snapshot.data));
            else
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 80, height: 80,child: CircularProgressIndicator(strokeWidth: 2.5)),
                    Padding(padding: EdgeInsets.all(20), child: Text('Scaneando Dispositivos', style: TextStyle(fontSize: 22),),)
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
