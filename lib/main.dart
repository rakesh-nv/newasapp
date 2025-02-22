import 'package:flutter/material.dart';
import 'package:newsapp/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: SplashScreen(),
    );
  }
}
