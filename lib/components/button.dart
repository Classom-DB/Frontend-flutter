import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({@required this.title, this.image, this.text});

  final Image image;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            if (image != null) image,
            if (text != null)
              Text(
                text,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
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
