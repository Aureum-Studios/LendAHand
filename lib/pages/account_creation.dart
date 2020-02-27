import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/services/app_localizations.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

class AccountCreation extends StatefulWidget {
  @override
  _AccountCreationState createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  final GlobalKey<FormState> _accountKey = new GlobalKey<FormState>();
  String _email;
  String _name;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate
          ("account_creation_title")),
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
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0)),
                      hintText: 'Ex johndoe@email.com',
                      labelText: 'EMAIL'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  EmailValidator.validate(value)
                      ? null
                      : AppLocalizations.of(context).translate
                    ("email_validation_hint"),
                  onSaved: (value) => _email = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0)),
                      hintText: 'Ex John Doe',
                      labelText: 'NAME'),
                  validator: (value) =>
                  value.isNotEmpty ? null : AppLocalizations.of(context)
                      .translate("name_validaton_hint"),
                  onSaved: (value) => _name = value,
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
                      return AppLocalizations.of(context).translate
                        ("value_less_than_eight_chars");
                    else if (value.length > 16)
                      return AppLocalizations.of(context).translate(
                          "value_more_than_sixteen_chars");
                    else
                      return null;
                  },
                  onSaved: (value) => _password = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (_accountKey.currentState.validate()) {
                      _accountKey.currentState.save();

                      //Call Firebase to create Authenticated User.
                      try {
                        FirebaseUser result =
                        await Provider.of<AuthService>(context)
                            .createUser(email: _email, password: _password);
                        print(result);
                        Navigator.pushReplacementNamed(context, '/home');
                      } on AuthException catch (error) {
                        // handle the firebase specific error
                        return _buildErrorDialog(context, error.message);
                      } on Exception catch (error) {
                        // gracefully handle anything else that might happen..
                        return _buildErrorDialog(context, error.toString());
                      }
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

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).translate('error_message')),
        content: Text(_message),
        actions: [
          FlatButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
