import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_classom/components/button.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Claim extends StatefulWidget {
  @override
  _ClaimState createState() => _ClaimState();
}

class _ClaimState extends State<Claim> {
  String _timeString;
  Timer _timerClock;

  String _title = '';

  final myController = TextEditingController();

  _postRequest(String type) async {
    String url = 'https://cors-anywhere.herokuapp.com/http://hsmint-hong.iptime.org:7001/claim/add';
    try {
      await http.post(url, body: {'guest_id': 'a1', 'message': myController.text, 'in_time': _formatDateTime(DateTime.now()), 'type': type});
    } catch (e) {
      print(e);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("요청 사항이 접수 되었습니다.", style: TextStyle(fontSize: 30.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기", style: TextStyle(fontSize: 20.0)),
              onPressed: () {
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
  }

  @override
  void dispose() {
    _timerClock.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/claim/background.png"),
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
                SizedBox(height: 20.0),
                Text(
                  '요청 사항',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print("pressed claim");
                            _title = "객실 물품 요청";
                          });
                        },
                        child: Button(
                          image: 'images/claim/item.png',
                          title: '객실 물품',
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('pressed fix');
                            _title = "객실 정비 요청";
                          });
                        },
                        child: Button(
                          image: 'images/claim/fix.png',
                          title: '객실 정비',
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print("pressed change");
                            _title = "객실 교체 요청";
                          });
                        },
                        child: Button(
                          image: 'images/claim/change.png',
                          title: '객실 교체',
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print("pressed other");
                            _title = "기타 요청사항";
                          });
                        },
                        child: Button(
                          image: 'images/claim/other.png',
                          title: '기타 요청',
                        ),
                      ),
                    ),
                  ],
                ),
                if (_title != '')
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 30.0, top: 15.0),
                            child: Text(
                              _title,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            margin: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextField(
                              controller: myController,
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          '취소',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 10.0, color: Colors.grey.shade700),
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.grey.shade700,
                                      ),
                                      width: 100.0,
                                      height: 60.0,
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          _title = '';
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(width: 30.0),
                                  GestureDetector(
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            '요청',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 10.0, color: Colors.grey.shade700),
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.grey.shade700,
                                        ),
                                        width: 100.0,
                                        height: 60.0,
                                      ),
                                      onTap: () {
                                        print('pressed 요청');
                                        print(myController.text);
                                        if (_title == '객실 물품 요청')
                                          _postRequest('problem');
                                        else if (_title == '객실 정비 요청')
                                          _postRequest('amenity');
                                        else if (_title == '객실 교체 요청')
                                          _postRequest('croom');
                                        else
                                          _postRequest('etc');
                                        myController.clear();
                                        _title = '';
                                        _showDialog();
                                      }),
                                  SizedBox(width: 30.0),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 60.0),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
