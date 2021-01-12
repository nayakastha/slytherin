import 'package:flutter/material.dart';
import 'package:snake_game/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slither Snake',
      theme: ThemeData.dark().copyWith(
          primaryColor: Color.fromRGBO(0, 63, 92, 1),
          accentColor: Color.fromRGBO(251, 91, 90, 1)),
      home: HomePage(),
    );
  }
}
