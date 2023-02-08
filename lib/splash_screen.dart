import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(0,100,0,0),
          color: Colors.white,
          alignment: Alignment.topCenter,
          child:Image.asset(
            'assets/olaLogo.png',
            width: 200,
            height: 200,

          )
      ),
    );
  }


}