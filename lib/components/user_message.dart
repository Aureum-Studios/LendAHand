import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String sender;
  final String text;
  final bool user;

  const Message({Key key, this.sender, this.text, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
        user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender),
          Material(
            color: user ? Colors.blue : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}
