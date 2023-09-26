import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/models/makers.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/position_service.dart';
import 'package:safe_pink/view/login/auth_widget.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Safe Pink",
    notificationText: "Monitorando sua localização",
    notificationImportance: AndroidNotificationImportance.Max,
    notificationIcon: AndroidResource(
      name: 'launcher_icon',
      defType: 'mipmap',
    ), // Default is ic_launcher from folder mipmap
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);

  if (success) {
    await FlutterBackground.enableBackgroundExecution();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => Usuario()),
        ChangeNotifierProvider(create: (context) => PositionService()),
        ChangeNotifierProvider(create: (context) => MarkersEntity())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const AuthWidget(),
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromARGB(255, 239, 7, 96)),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
