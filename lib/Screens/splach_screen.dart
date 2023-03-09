import 'package:creativa_fproject/Screens/Home.dart';
import 'package:creativa_fproject/Screens/Login.dart';
import 'package:creativa_fproject/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), _checkAuthState);
  }
  void _checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final access = await prefs.get('access_token');
    if(access==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animation/Splach.json'),
      ),
    );
  }
}
