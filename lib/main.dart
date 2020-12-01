import 'package:flutter/material.dart';
import 'package:flutter_classom/screens/claim.dart';
import 'package:flutter_classom/screens/drink.dart';
import 'package:flutter_classom/screens/facility.dart';
import 'package:flutter_classom/screens/korean.dart';
import 'package:flutter_classom/screens/other.dart';
import 'package:flutter_classom/screens/room.dart';
import 'package:flutter_classom/screens/home.dart';
import 'package:flutter_classom/screens/western.dart';

void main() => runApp(Hotel());

class Hotel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/facility': (context) => Facility(),
        '/claim': (context) => Claim(),
        '/room': (context) => Room(),
        '/room/korean': (context) => Korean(),
        '/room/western': (context) => Western(),
        '/room/other': (context) => Other(),
        '/room/drink': (context) => Drink(),
      },
    );
  }
}
