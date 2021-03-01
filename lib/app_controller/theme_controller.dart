import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkThemeActive = false;

  bool get isDarkMode => _isDarkThemeActive;

  ThemeMode get appTheme {
    if (_isDarkThemeActive) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  changeTheme() {
    _isDarkThemeActive = !_isDarkThemeActive;
    notifyListeners();
  }

  Widget changeThemeSwitch(BuildContext context) {
    return ListTile(
      title: Text('Dark Mode', style: TextStyle(fontSize: 15),),
      leading: Icon(Icons.brightness_2),
      trailing: Switch(
        value: Provider.of<ThemeController>(context).isDarkMode,
        onChanged: (value) {
          changeTheme();
        },
      ),
    );
  }
}