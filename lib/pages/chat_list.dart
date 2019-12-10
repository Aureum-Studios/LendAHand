import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Container(
          child: Text('Chat list.')
        )
    );
  }
}
