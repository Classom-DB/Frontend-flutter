import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  Item({@required this.title, @required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Image.asset(image, width: 200.0, height: 200.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      width: 250.0,
      height: 250.0,
    );
  }
}
