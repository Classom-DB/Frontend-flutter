import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_classom/components/dataBloc.dart';
import 'package:flutter_classom/model/data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String _timeString;
  Timer _timerClock;
  List<Menu> items = bloc.data;
  int money = 0;

  void _showDialog(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("주문 정보", style: TextStyle(fontSize: 25.0)),
          content: Text(text, style: TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            FlatButton(
              child: new Text("확인", style: TextStyle(fontSize: 18.0)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _postMenu() async {
    String menu = "";
    String url = 'https://cors-anywhere.herokuapp.com/http://hsmint-hong.iptime.org:7001/roomservice/add';
    for (var item in items) {
      menu += item.item + " " + item.count.toString() + "\n";
    }
    try {
      await http.post(url, body: {'guest_id': 'a1', 'menu': menu, 'in_time': _formatDateTime(DateTime.now())});
      url = 'http://hsmint-hong.iptime.org:7001/income/add';
      var send = {"year": DateTime.now().year.toString(), "month": DateTime.now().month.toString(), "day": DateTime.now().day.toString(), "guest_id": "a1", "amount": money.toString(), "type": "room"};
      await http.post(url, body: send);
    } catch (e) {
      print(e);
    }
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _getMoney() {
    for (var item in items) {
      money += item.money * item.count;
    }
  }

  String _formatPostDate(DateTime now) {
    return DateFormat('yyyy-mm-dd hh:mm:ss').format(now);
  }

  String _formatDateTime(DateTime now) {
    return DateFormat('yyyy.MM.dd   hh:mm').format(now);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timerClock = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    _getMoney();
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
              image: AssetImage("images/main/background.jpg"),
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
              SizedBox(height: 30.0),
              Text(
                '룸 서비스 주문',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 60.0, top: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      if (items != null)
                        Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 80.0),
                                    Text(
                                      items[index].item,
                                      style: TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      items[index].money.toString() + "₩",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 50.0,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (items[index].count != 9) {
                                            items[index].count++;
                                            money += items[index].money;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(width: 20.0),
                                    Text(
                                      items[index].count.toString(),
                                      style: TextStyle(fontSize: 40.0),
                                    ),
                                    SizedBox(width: 20.0),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.remove_circle_rounded,
                                        size: 50.0,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (items[index].count != 0) {
                                            items[index].count--;
                                            money -= items[index].money;
                                          }
                                          if (items[index].count == 0) {
                                            bloc.removeItem(index);
                                            items.removeAt(index);
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(width: 80.0),
                                  ],
                                ),
                                alignment: Alignment.centerLeft,
                                height: 100.0,
                              );
                            },
                          ),
                        ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0, right: 80.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                money.toString() + "₩",
                                style: TextStyle(
                                  fontSize: 40.0,
                                ),
                              ),
                              SizedBox(width: 40.0),
                              GestureDetector(
                                child: Container(
                                  child: Text(
                                    '주문하기',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (money != 0) {
                                    _postMenu();
                                    bloc.clearItem();
                                    _showDialog('해당 메뉴를 주문하였습니다.');
                                  } else {
                                    _showDialog('주문 내역에 정보가 없습니다.');
                                  }
                                  setState(() {
                                    money = 0;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
