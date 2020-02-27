import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/conversation_page.dart';

class UserConversation extends StatelessWidget {
  final String email;
  final FirebaseUser firebaseUser;

  const UserConversation({Key key, this.email, this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
            left: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
            right: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
            top: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber)),
      ),
      child: Row(
        children: <Widget>[
          Text(email),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0)),
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                                 MaterialPageRoute(
                                     builder: (context) => Conversation(receiver: email, firebaseUser: firebaseUser)));
            },
            color: Colors.amber,
            child: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
