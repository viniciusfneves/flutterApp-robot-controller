import 'package:blue_app/utils/bluetooth.dart';
import 'package:blue_app/utils/screen_base.dart';
import 'package:flutter/material.dart';

class ConectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConectionPage();
}

class _ConectionPage extends State<ConectionPage> {
  final Bluetooth blue = Bluetooth();
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: FutureBuilder(
          future: blue.deviceScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return (Center(child: snapshot.data));
            else
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromARGB(255, 200, 0, 0)),
                        )),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Scaneando Dispositivos',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
