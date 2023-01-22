import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screen/home_screen.dart';
import 'package:zoom_clone/screen/login_screen.dart';
import 'package:zoom_clone/screen/video_call_screen.dart';
import 'package:zoom_clone/utils/colors.dart';

import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            //if snapshot data is not recived yet so its waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //snapshot has data it will send to homescreen
            if (snapshot.hasData) {
              return HomeScreen();
            }
            //else login screen
            return LoginScreen();
          }),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/video-call': (context) => VideoCallScreen()
      },
    );
  }
}
