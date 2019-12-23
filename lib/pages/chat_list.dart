import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  final FirebaseUser firebaseUser;

  const ChatList({Key key, this.firebaseUser}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Messages'),
         centerTitle: true,
         backgroundColor: Colors.amber,
       ),
      body: Container(
        child: Text(widget.firebaseUser.email),
      ),
    );
  }
}
