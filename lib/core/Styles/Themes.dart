import 'package:flutter/material.dart';

import 'Colors.dart';

class Themes {
  static final dark = ThemeData(
    // brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return purpleColor;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.all(purpleColor.withOpacity(0.2)),
    ),
  );
  static final light = ThemeData(
    // brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: purpleColor),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.grey[800]),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return purpleColor;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.all(purpleColor.withOpacity(0.2)),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  // bool isOn = false;

  // ThemeData get currentTheme => isOn ? Themes.dark : Themes.light;
  // toggleTheme() {
  //   isOn = !isOn;
  //   notifyListeners();
  // }
}
