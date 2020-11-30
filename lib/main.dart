import 'package:flutter/material.dart';
import 'package:flutter_classom/screens/facility.dart';
import 'screens/home.dart';

void main() => runApp(Hotel());

class Hotel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/facility': (context) => Facility(),
      },
    );
  }
}
