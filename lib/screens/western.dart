import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_classom/components/dataBloc.dart';
import 'package:flutter_classom/components/item.dart';
import 'package:flutter_classom/model/data.dart';
import 'package:intl/intl.dart';

class Western extends StatefulWidget {
  @override
  _WesternState createState() => _WesternState();
}

class _WesternState extends State<Western> {
  String _timeString;
  Timer _timerClock;

  void _showDialog(String text, int money) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("양식", style: TextStyle(fontSize: 25.0)),
          content: Text(text + "을/를 담겠습니까?", style: TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            FlatButton(
              child: new Text("취소", style: TextStyle(fontSize: 18.0)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: new Text("확인", style: TextStyle(fontSize: 18.0)),
              onPressed: () {
                bloc.addItem(Menu(item: text, count: 1, money: money));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
                '양식 메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60.0),
              Container(
                height: 350.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50.0),
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/western/karbonara.jpg',
                          title: '까르보나라\n25000₩',
                        ),
                        onTap: () {
                          _showDialog('까르보나라', 25000);
                        },
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/western/toast.jpg',
                          title: '토스트\n9000₩',
                        ),
                        onTap: () {
                          _showDialog('토스트', 9000);
                        },
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/western/steak.jpg',
                          title: '스테이크\n32000₩',
                        ),
                        onTap: () {
                          _showDialog('스테이크', 32000);
                        },
                      ),
                      width: 300.0,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Item(
                          image: 'images/room/western/tomato.jpg',
                          title: '토마토파스타\n23000₩',
                        ),
                        onTap: () {
                          _showDialog('토마토파스타', 23000);
                        },
                      ),
                      width: 300.0,
                    ),
                  ],
                ),
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
