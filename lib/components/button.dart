import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({@required this.title, this.image, this.text});

  final String image;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            if (image != null) Image.asset(image, width: 180.0, height: 140.0),
            if (text != null)
              Container(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                width: 180.0,
                margin: EdgeInsets.only(top: 30.0, bottom: 35.8),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
