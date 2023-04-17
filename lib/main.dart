import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'homepage.dart';
import 'basicform.dart';
import 'bankform.dart';
import 'damageform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application. @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Disaster Management',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/homepage': (BuildContext context) => HomePage(),
          '/basicform': (BuildContext context) =>  BasicForm(),
          '/bankform': (BuildContext context) =>  BankForm(),
          '/damageform': (BuildContext context) =>  DamageForm(),

        });
  }
}

