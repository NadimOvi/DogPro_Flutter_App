import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dog_breed/page/home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      setState(() {
        Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard())));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SplashScreenView(
          navigateRoute: Dashboard(),
          duration: 10000,
          imageSize: 250,
          imageSrc: "assets/dogimage.png",
          backgroundColor: Color(0xff15282E),
        ),



      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
