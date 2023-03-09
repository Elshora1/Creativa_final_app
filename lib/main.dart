import 'package:creativa_fproject/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'Screens/splach_screen.dart';
import 'Screens/Login.dart';

void main() {
  runApp(FinalApp());
}
class FinalApp extends StatelessWidget {
  const FinalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}
