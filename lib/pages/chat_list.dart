import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lend_a_hand/services/auth_service.dart';

class ChatList extends StatefulWidget {
  final FirebaseUser firebaseUser;

  const ChatList({Key key, this.firebaseUser}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  var _messages;

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<void> callback() async {
    if (_controller.text.length > 0) {
      await _firestore
          .collection('messages')
          .add({'text': _controller.text, 'sender': widget.firebaseUser.email, 'date': DateTime.now().toIso8601String().toString()});
      _controller.clear();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          curve: Curves.easeOut, duration: Duration(milliseconds: 300));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _messages = StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        });

        List<DocumentSnapshot> docs = snapshot.data.documents;
        List<Widget> messages = docs.map((doc) =>
        new Message(
            sender: doc.data['sender'],
            text: doc.data['text'],
            user: widget.firebaseUser.email == doc.data['sender'])
        ).toList();

        return ListView(
          controller: _scrollController,
          children: <Widget>[...messages],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _messages
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) => callback(),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      border: OutlineInputBorder(),
                    ),
                  )),
                  SendButton(
                    text: "Send Message",
                    callback: callback,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      child: Text(text),
      color: Colors.amber,
    );
  }
}

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
