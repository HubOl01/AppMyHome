import 'dart:async';
import 'dart:io';
import 'package:MyAppHome/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'bottomNavigation.dart';
import 'core/Data/usersData.dart';
import 'core/Model/User.dart';
import 'core/PushNotifications/api/notification.dart';
import 'core/Styles/Colors.dart';
import 'pages/Login/LoginPage.dart';

Future<void> initializeDefaultFromAndroidResource() async {
  if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) {
    print('Not running on Android, skipping');
    return;
  }
  FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app $app from Android resource');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const SizedBox();
  };
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpOverrides();
  Notific();
  //await base.addUsers(users);

  // runApp(LoadingPage());
  runApp(MyApp(user: users[5]));
  // runApp(LoginPage());
}

class MyApp extends StatelessWidget {
  final User user;
  const MyApp({required this.user});
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: GetMaterialApp(
        home: HomePage(
          user: user,
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: purpleColor
          ),
          // scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(seedColor: purpleColor)),
      ),
    );
  }
}
