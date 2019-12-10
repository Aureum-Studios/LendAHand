import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth;
  FirebaseUser _firebaseUser;
  String accountStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Flutter Firebase"),
        //actions: <Widget>[LogoutButton()],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Account status: $accountStatus'),
            SizedBox(height: 20.0),
            Text(
              'Home Page Flutter Firebase  Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
//              "Welcome ${widget.currentUser.email}",
              "Welcome",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Icon(Icons.message),
              onPressed: () {
                Navigator.pushNamed(context, '/chatList');
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("LOGOUT"),
                onPressed: () async {
                  await Provider.of<AuthService>(context).logout();
                })
          ],
        ),
      ),
    );
  }

  getCurrentUser() async {
    _firebaseUser = await _auth.currentUser();
    print('Hello ${_firebaseUser.email.toString()}');
    setState(() {
      _firebaseUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
  }
}
