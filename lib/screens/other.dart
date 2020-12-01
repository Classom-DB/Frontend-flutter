import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_classom/components/item.dart';
import 'package:intl/intl.dart';

class Other extends StatefulWidget {
  @override
  _OtherState createState() => _OtherState();
}

class _OtherState extends State<Other> {
  String _timeString;
  Timer _timerClock;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime now) {
    return DateFormat('yyyy.MM.dd   hh:mm').format(now);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timerClock = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    _timerClock.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/room/background.jpg"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15.0),
              Container(
                child: Text(
                  _timeString,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                  right: 15.0,
                ),
              ),
              SizedBox(height: 80.0),
              Text(
                '일식/중식 메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 120.0),
              Container(
                height: 350.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50.0),
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/other/salmon.jpg',
                          title: '연어 초밥\n19000₩',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/other/ramen.jpg',
                          title: '라멘\n17000₩',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/other/jjambbong.png',
                          title: '짬뽕\n16000₩',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/other/manbosha.jpg',
                          title: '멘보샤(4pcs)\n20000₩',
                        ),
                      ),
                      width: 300.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
