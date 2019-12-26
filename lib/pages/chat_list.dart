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
      future: _firestore.collection("messages").document(widget.firebaseUser.email).collection('messages').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List<Widget> conversations = snapshot.data.documents.map((doc) =>
            new UserConversation(email: doc.documentID, userEmail: widget.firebaseUser.email)
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
  final String userEmail;

  const UserConversation({Key key, this.email, this.userEmail});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }}
