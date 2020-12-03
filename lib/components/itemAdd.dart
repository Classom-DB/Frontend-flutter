import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  Alert({@required this.item, @required this.many});

  final String item;
  final int many;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("CheckBox"),
      actions: <Widget>[
        Row(
          children: [
            Text(item),
            Column(
              children: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("확인"),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("취소"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
