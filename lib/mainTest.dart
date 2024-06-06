import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/Styles/Themes.dart';
import 'pages/Login/LoginPage.dart';


class MyAppTest extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
          return MaterialApp(
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            theme: Themes.light,
            darkTheme: Themes.dark,
            home: LoginPage(),
            // home: personalPage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
