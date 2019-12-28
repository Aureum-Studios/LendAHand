import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/conversation_page.dart';

class ChatList extends StatefulWidget {
  final FirebaseUser firebaseUser;

  const ChatList({Key key, this.firebaseUser}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final Firestore _firestore = Firestore.instance;

  var _conversations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _conversations = FutureBuilder<QuerySnapshot>(
      future: _firestore.collection("users").document(widget.firebaseUser.email).collection('conversions').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        print(snapshot.hasData);
        print(snapshot.data.documents.isEmpty);

        List<Widget> conversations = snapshot.data.documents.map((doc) =>
            new UserConversation(email: doc.documentID, firebaseUser: widget.firebaseUser)
        ).toList();

        return ListView(
          children: <Widget>[...conversations],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Messages'),
         centerTitle: true,
         backgroundColor: Colors.amber,
       ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _conversations,
            )
          ],
        ),
      ),
    );
  }
}

class UserConversation extends StatelessWidget {
  final String email;
  final FirebaseUser firebaseUser;

  const UserConversation({Key key, this.email, this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
          left: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
          right: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber),
          top: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.amber)
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(email),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0)),
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Conversation(reciever: email, firebaseUser: firebaseUser)
              ));
            },
            color: Colors.amber,
            child: Icon(
              Icons.edit
            ),
          )
        ],
      ),
    );
  }}
