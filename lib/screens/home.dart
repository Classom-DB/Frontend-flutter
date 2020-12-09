import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_classom/components/button.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _timeString;
  Timer _timerClock;
  String _parkingLot;

  int _tap = 0;

  _getData() async {
    Map<String, String> headers = {'Host': 'cors-anywhere.herokuapp.com', 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8', 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101 Firefox/83.0'};
    String url = 'https://cors-anywhere.herokuapp.com/http://hsmint-hong.iptime.org:7001/parking/pad/get/a1';
    try {
      http.Response response = await http.get(url, headers: headers);
      var data = jsonDecode(response.body);
      _parkingLot = 'FLOOR: B' + data['data'][0]['floor'].toString() + '\nSECTION: ' + data['data'][0]['section'];
      print(_parkingLot);
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

  String _formatDateTime(DateTime now) {
    return DateFormat('yyyy.MM.dd   hh:mm').format(now);
  }

  @override
  void initState() {
    _getData();
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
              Text(
                'Classom',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 180,
                  fontFamily: 'Gabriola',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '안녕하세요, 호텔 Classom 입니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
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
                          Navigator.pushNamed(context, '/claim');
                        });
                      },
                      child: Button(
                        image: 'images/main/claim.png',
                        title: '요청사항',
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/room');
                        });
                      },
                      child: Button(
                        image: 'images/main/roomservice.png',
                        title: '룸서비스',
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_tap == 0)
                            _tap = 1;
                          else
                            _tap = 0;
                        });
                      },
                      child: Button(
                        title: _tap == 0 ? '주차현황' : '',
                        image: _tap == 0 ? 'images/main/parking.png' : null,
                        text: _tap == 1 ? _parkingLot : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/facility');
                        });
                      },
                      child: Button(
                        image: 'images/main/facility.png',
                        title: '시설정보',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
