import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_classom/components/button.dart';
import 'package:intl/intl.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
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
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
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
                '룸서비스',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Button(
                        title: '한식',
                        image: 'images/room/korean.png',
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/room/korean');
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Button(
                        title: '양식',
                        image: 'images/room/western.png',
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/room/western');
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Button(
                        title: '일식/중식',
                        image: 'images/room/other.png',
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/room/other');
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Button(
                        title: '커피/음료',
                        image: 'images/room/drink.png',
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/room/drink');
                        });
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  child: GestureDetector(
                    child: Image.asset(
                      'images/room/order.png',
                      width: 180.0,
                    ),
                    onTap: () {
                      print('pressed');
                      Navigator.pushNamed(context, '/room/order');
                    },
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
