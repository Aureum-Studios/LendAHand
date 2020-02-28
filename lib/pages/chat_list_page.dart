import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/components/user_conversation.dart';

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
    super.initState();

    // TODO: Need to create link between chat documents within collection to user's active chats to build out conversations list, currently mocked.
    _conversations = FutureBuilder<QuerySnapshot>(
      future: _firestore.collection("chats").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        print(snapshot.hasData);
        print(snapshot.data.documents.isEmpty);

        List<Widget> conversations = snapshot.data.documents
            .map((doc) => new UserConversation(email: doc.documentID, firebaseUser: widget.firebaseUser))
            .toList();

        return ListView(
          children: <Widget>[...conversations],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
