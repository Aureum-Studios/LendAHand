import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lend_a_hand/services/account_service.dart';

class AccountCreation extends StatefulWidget {
  @override
  _AccountCreationState createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  final GlobalKey<FormState> _accountKey = new GlobalKey<FormState>();
  String email;
  String name;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Form(
          key: _accountKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    hintText: 'Ex johndoe@email.com',
                    labelText: 'EMAIL'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => EmailValidator.validate(value) ? null : 'Please enter a valid email',
                  onSaved: (value) => email = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    hintText: 'Ex John Doe',
                    labelText: 'NAME'),
                  validator: (value) => value.isNotEmpty ? null : 'Please enter a name',
                  onSaved: (value) => name = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    labelText: 'PASSWORD',
                  ),
                  validator: (value) {
                    if (value.length < 8)
                      return 'Invalid password, minimum length: 8 characters';
                    else if (value.length > 16)
                      return 'Invalid password, maximum length 16 characters';
                    else
                      return null;
                  },
                  onSaved: (value) => password = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_accountKey.currentState.validate()) {
                      _accountKey.currentState.save();

                      //Call Firebase to create Authenticated User.
                      accountService.saveAccount(email, name, password);
                    }
                  },
                  color: Colors.amber,
                  child: Text('Sign Up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
