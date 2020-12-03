import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_classom/components/button.dart';
import 'package:intl/intl.dart';

class Facility extends StatefulWidget {
  @override
  _FacilityState createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  List<int> tap = [0, 0, 0, 0, 0, 0, 0, 0];

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
              image: AssetImage("images/facility/background.jpg"),
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
                '호텔 시설 운영 정보',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
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
                          if (tap[0] == 0)
                            tap[0] = 1;
                          else
                            tap[0] = 0;
                        });
                      },
                      child: Button(
                        title: '결혼식장',
                        image: tap[0] == 0 ? 'images/facility/wedding.png' : null,
                        text: tap[0] == 1 ? '2층\n 10:00 ~ 21:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[1] == 0)
                            tap[1] = 1;
                          else
                            tap[1] = 0;
                        });
                      },
                      child: Button(
                        title: '레스토랑',
                        image: tap[1] == 0 ? 'images/facility/restaurant.png' : null,
                        text: tap[1] == 1 ? '21층\n 11:30 ~ 22:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[2] == 0)
                            tap[2] = 1;
                          else
                            tap[2] = 0;
                        });
                      },
                      child: Button(
                        title: '라운지',
                        image: tap[2] == 0 ? 'images/facility/rounge.png' : null,
                        text: tap[2] == 1 ? '21층\n 09:00 ~ 22:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[3] == 0)
                            tap[3] = 1;
                          else
                            tap[3] = 0;
                        });
                      },
                      child: Button(
                        title: '바',
                        image: tap[3] == 0 ? 'images/facility/bar.png' : null,
                        text: tap[3] == 1 ? '1층\n 19:00 ~ 02:00' : null,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[4] == 0)
                            tap[4] = 1;
                          else
                            tap[4] = 0;
                        });
                      },
                      child: Button(
                        title: '연회장',
                        image: tap[4] == 0 ? 'images/facility/hall.png' : null,
                        text: tap[4] == 1 ? '3층\n 10:00 ~ 21:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[5] == 0)
                            tap[5] = 1;
                          else
                            tap[5] = 0;
                        });
                      },
                      child: Button(
                        title: '피트니스',
                        image: tap[5] == 0 ? 'images/facility/fitness.png' : null,
                        text: tap[5] == 1 ? '5층\n 07:00 ~ 22:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[6] == 0)
                            tap[6] = 1;
                          else
                            tap[6] = 0;
                        });
                      },
                      child: Button(
                        title: '스파',
                        image: tap[6] == 0 ? 'images/facility/spa.png' : null,
                        text: tap[6] == 1 ? '5층\n 07:00 ~ 22:00' : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tap[7] == 0)
                            tap[7] = 1;
                          else
                            tap[7] = 0;
                        });
                      },
                      child: Button(
                        title: '수영장',
                        image: tap[7] == 0 ? 'images/facility/pool.png' : null,
                        text: tap[7] == 1 ? '4층\n 10:00 ~ 21:00' : null,
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
