import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //TODO: Rewrite the FutureBuilder to have better return types.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  FirebaseUser user = snapshot.data;
                  return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 8.0),
                                child: Container(
                                    width: 190,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(user.photoUrl),
                                        )))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 8.0),
                              child: Text('Name: ${user.displayName ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Phone Number: ${user.phoneNumber ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Email: ${user.email ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ));
                }
                return Text('');
              default:
                return Text('');
            }
          }),
    );
  }
}
