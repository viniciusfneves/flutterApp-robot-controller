import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier{
  bool _isDarkTheme = false;
  bool get isDarkMode => _isDarkTheme; 

  changeTheme(){
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}


              