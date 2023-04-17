import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [Colors.white, Colors.purple[900]],
    ),
  ),

      
     child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(children: [
            Image.asset(
              "assets/images/TamilNadu_Logo.png",
              width: 70,
              height: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Govt of Tamil Nadu',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          Column(children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  //colorFilter: ColorFilter.mode(Colors.indigo[400], BlendMode.dstATop)
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Disaster Management',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.purple[700],
                  decoration: TextDecoration.none,
                  fontFamily: 'RobotoMono',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Image.asset(
            "assets/images/nic_logo.png",
            height: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
