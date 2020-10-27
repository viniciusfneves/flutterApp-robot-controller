import 'package:flutter/material.dart';

class ThemeController extends StatefulWidget {
  @override
  _ThemeControllerState createState() => _ThemeControllerState();
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
          });
        },
      ),
    );
  }
}

              