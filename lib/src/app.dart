import 'package:flutter/material.dart';
import 'screens/homeScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'techzombie',
      home: HomeScreen(),
    );
  }
}
