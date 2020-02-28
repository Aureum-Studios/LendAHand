import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lend_a_hand/components/send_message_button.dart';
import 'package:lend_a_hand/components/user_message.dart';
import 'package:lend_a_hand/services/app_localizations.dart';

class Conversation extends StatefulWidget {
  final FirebaseUser firebaseUser;
  final String receiver;

  const Conversation({Key key, this.firebaseUser, this.receiver}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  var _messages;

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<void> callback() async {
    if (_controller.text.length > 0) {
      var data = {
        'text': _controller.text,
        'sender': widget.firebaseUser.email,
        'date': DateTime.now().toIso8601String()
      };
      await _firestore.collection('chats').document(widget.firebaseUser.email).updateData({
                                                                                            'messages': FieldValue
                                                                                                .arrayUnion([data])
                                                                                          });
      _controller.clear();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          curve: Curves.easeOut, duration: Duration(milliseconds: 300));
    }
  }

  @override
  void initState() {
    super.initState();

    _messages = StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('chats').document(widget.firebaseUser.email).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        });

        List list = snapshot.data.data['messages'];
        List<Widget> messages = list
            .map((message) =>
        new Message(
          sender: message['sender'],
          text: message['text'],
          user: widget.firebaseUser.email == message['sender'],
          ))
            .toList();

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
          title: Text(AppLocalizations.of(context).translate('messages_page_title')),
          backgroundColor: Colors.amber,
          centerTitle: true,
          ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _messages),
              Container(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) => callback(),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate('message_input_hint'),
                      border: OutlineInputBorder(),
                      ),
                  )),
                  SendButton(
                    text: AppLocalizations.of(context).translate('send_message_hint'),
                    callback: callback,
                    )
                ],
              ))
            ],
          ),
        ));
  }
}
