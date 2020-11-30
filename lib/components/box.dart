import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box({@required this.title, this.image, this.info});

  final String title;
  final String image;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Image.asset(
              image,
              width: 180.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      width: 250.0,
      height: 250.0,
    );
  }
}
