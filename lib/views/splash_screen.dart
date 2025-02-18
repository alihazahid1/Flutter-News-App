

import 'dart:async';

import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/splash_pic.jpg',
                fit: BoxFit.cover,
                width: width*.9,
                height: height*.5,),
              SizedBox(height: height*0.04,),
              Text('TOP HEADLINES'),
              SizedBox(height: height*0.04,),
              SpinKitChasingDots(
                color: Colors.blue,
                size: 40,
              )
            ],
          ),
        )
    );
  }
}
