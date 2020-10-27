import 'dart:async';

import 'package:flutter/material.dart';

class ThemeController extends StatefulWidget {
  @override
  _ThemeControllerState createState() => _ThemeControllerState();
  // This Stream is a infinite Stream of data, so it will never be closed.
  // It will push information about the current state of theme and be responsable for changing it
  // ignore: close_sinks
  final StreamController<bool> _dataStream = new StreamController<bool>();
  Stream<bool> get appTheme => _dataStream.stream;

  void addToStream(bool data){
    print('adding to stream $data');
    _dataStream.sink.add(data);
  }

}

class _ThemeControllerState extends State<ThemeController> {
  bool _isDarkThemeActive = false;

  void changeTheme(bool currentTheme) {
    _isDarkThemeActive = !currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Dark Mode',
        style: TextStyle(fontSize: 15),
      ),
      leading: Icon(
        Icons.brightness_2,
        size: 22,
      ),
      trailing: Switch(
        value: _isDarkThemeActive,
        onChanged: (bool value) {
          setState(() {
            changeTheme(_isDarkThemeActive);
            widget.addToStream(_isDarkThemeActive);
          });
        },
      ),
    );
  }
}

              